!/bin/bash -e
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
    gsutil cp ${bucket_url}/responses.properties /opt/vcd_files/
}

function install_vcd () {
    chmod +x /opt/vcd_files/${vcd_binary_filename}
    echo "N" | /opt/vcd_files/${vcd_binary_filename}
    instance_ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)
    /opt/vmware/vcloud-director/bin/configure -r /opt/vcd_files/responses.properties -ip $instance_ip --primary-port-http 80 --primary-port-https 443  --cert /opt/vcd_files/${vcd_cert_file} --key /opt/vcd_files/${vcd_cert_private_key_file} --key-password "${vcd_cert_private_key_password}"  --enable-ceip true -unattended
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

    sed -i "s/Xms1024M/Xms2048M/g" /opt/vmware/vcloud-director/bin/vmware-vcd-cell-common
    sed -i "s/Xmx4096M/Xmx${vcd_heap_size_max}M/g" /opt/vmware/vcloud-director/bin/vmware-vcd-cell-common
}

function start_vcd_service() {
    service vmware-vcd start
}

##################################### End Function Definitions

# Call Functions
install_prerequisites
mount_transfer_store
prepare_vcd_files
install_vcd
customize_and_configure_vcd
start_vcd_service
