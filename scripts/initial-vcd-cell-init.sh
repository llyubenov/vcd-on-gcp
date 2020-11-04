#!/bin/sh
yum install nfs-utils wget alsa-lib libICE libSM libX11 libXau libXdmcp libXext libXi libXt libXtst redhat-lsb pciutils -y

mkdir -p /opt/vmware/vcloud-director/data/transfer
echo "${transfer_mount_ip}:/${transfer_mount_name}   /opt/vmware/vcloud-director/data/transfer    nfs     rw,vers=3,rsize=32768,wsize=32768,hard,timeo=600  0 0" >> /etc/fstab
mount -a
systemctl stop firewalld
systemctl disable firewalld

gsutil cp ${bucket_url}/${vcd_binary_filename} /tmp/
gsutil cp ${bucket_url}/${vcd_keystore_filename} /tmp/

chmod +x /tmp/${vcd_binary_filename}
echo "N" | /tmp/${vcd_binary_filename}

instance_ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

/opt/vmware/vcloud-director/bin/configure -ip $instance_ip --primary-port-http 80 --primary-port-https 443 -cons $instance_ip --console-proxy-port-https 8443 -dbhost ${vcd_db_instance_ip} -dbport 5432 -dbtype postgres -dbname ${vcd_db_name} -dbuser ${vcd_db_username} -dbpassword "${vcd_db_username_password}" --keystore /tmp/${vcd_keystore_filename} -w "${vcd_keystore_filename_password}"  --enable-ceip true -unattended

cat >> /opt/vmware/vcloud-director/etc/global.properties <<- EOF
# Custom Changes Made for console proxy and DB connections
consoleproxy.websockets.enabled = true
consoleproxy.securenio.buffer.size = 17000
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

service vmware-vcd start
sleep 180
service vmware-vcd stop

gsutil cp /opt/vmware/vcloud-director/etc/responses.properties ${bucket_url}/responses.properties