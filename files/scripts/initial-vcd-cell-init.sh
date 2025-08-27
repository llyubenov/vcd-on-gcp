#!/bin/bash -e
# vCD Primary Cell bootstrapping

# Redirect script output to a log file
exec > /var/log/vcd_main_bootstrap.log                                                                  
exec 2>&1

# Configuration
PROGRAM='Main vCD Cell'

##################################### Functions Definitions
function install_prerequisites () {
    yum update -y
    yum install nfs-utils wget alsa-lib libICE libSM libX11 libXau libXdmcp libXext libXi libXt libXtst pciutils chkconfig initscripts -y
}

function mount_transfer_store () {
    mkdir -p /opt/vmware/vcloud-director/data/transfer
    echo "${transfer_mount_ip}:/${transfer_mount_name}   /opt/vmware/vcloud-director/data/transfer    nfs     rw,vers=3,rsize=32768,wsize=32768,hard,timeo=600  0 0" >> /etc/fstab
    mount -a
    systemctl stop firewalld
    systemctl disable firewalld
}

function prepare_vcd_files () {
    mkdir -p /opt/vcd_files
    gsutil cp ${bucket_url}/${vcd_binary_filename} /opt/vcd_files/
    gsutil cp ${bucket_url}/${vcd_cert_file} /opt/vcd_files/
    gsutil cp ${bucket_url}/${vcd_cert_private_key_file} /opt/vcd_files/
}

function install_vcd () {
    chmod +x /opt/vcd_files/${vcd_binary_filename}
    echo "N" | /opt/vcd_files/${vcd_binary_filename}
    instance_ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
    /opt/vmware/vcloud-director/bin/configure --primary-ip $instance_ip --primary-port-http 80 --primary-port-https 443 --database-host ${vcd_db_instance_ip} --database-port 5432 --database-type postgres --database-name ${vcd_db_name} --database-user ${vcd_db_username} --database-password "${vcd_db_username_password}" --cert /opt/vcd_files/${vcd_cert_file} --key /opt/vcd_files/${vcd_cert_private_key_file} --key-password "${vcd_cert_private_key_password}" --enable-ceip true -unattended
}

function customize_and_configure_vcd () {
cat >> /opt/vmware/vcloud-director/etc/global.properties <<- EOF
# Custom Changes Made for DB connections
database.pool.maxActive = 200
vcloud.http.maxThreads = 150
vcloud.http.minThreads = 32
vcloud.http.acceptorThreads = 16
hibernate.generate_statistics=true

# Limit the number of active syncs per Subscribed Public Catalog
contentLibrary.item.sync.batch.size = 1

#Configure vCD to cleanup abandoned DB Threads
database.pool.removeAbandoned = true
database.pool.abandonWhenPercentageFull = 0
database.pool.removeAbandonedTimeout = 43200
EOF

    /opt/vmware/vcloud-director/bin/cell-management-tool system-setup --email ${vcd_admin_email} --full-name "${vcd_admin_fullname}" --installation-id ${vcd_installation_id} --password ${vcd_admin_password} --system-name "${vcd_system_name}" --serial-number ${vcd_serial_number} --user ${vcd_admin_username} -unattended

    export allowed_origins=`/opt/vmware/vcloud-director/bin/cell-management-tool manage-config -n webapp.allowed.origins -l | cut -d " " -f 5 | tr -d '"'`
    export allowed_origins_edited="$allowed_origins,http://${vcd_ui_ip},https://${vcd_ui_ip},${vcd_ui_ip}"
    /opt/vmware/vcloud-director/bin/cell-management-tool manage-config -n webapp.allowed.origins -v $allowed_origins_edited
    /opt/vmware/vcloud-director/bin/cell-management-tool manage-config -n ui.baseUri -v "https://${vcd_ui_ip}"
    /opt/vmware/vcloud-director/bin/cell-management-tool manage-config -n ui.baseHttpUri -v "http://${vcd_ui_ip}"
    /opt/vmware/vcloud-director/bin/cell-management-tool manage-config -n restapi.baseUri -v "https://${vcd_ui_ip}"
    /opt/vmware/vcloud-director/bin/cell-management-tool manage-config -n restapi.baseHttpUri -v "http://${vcd_ui_ip}"
}

function vcd_service_lifecycle () {
    service vmware-vcd start
    sleep 240
    service vmware-vcd stop
}

function copy_responces_file () {
    gsutil cp /opt/vmware/vcloud-director/etc/responses.properties ${bucket_url}/responses.properties
}

##################################### End Function Definitions

# Call Functions
install_prerequisites
mount_transfer_store
prepare_vcd_files
install_vcd
customize_and_configure_vcd
vcd_service_lifecycle
copy_responces_file
