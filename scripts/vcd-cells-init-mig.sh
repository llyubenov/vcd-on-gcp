#!/bin/sh    
yum update -y
yum install nfs-utils wget alsa-lib libICE libSM libX11 libXau libXdmcp libXext libXi libXt libXtst redhat-lsb pciutils -y

mkdir -p /opt/vmware/vcloud-director/data/transfer
echo "${transfer_mount_ip}:/${transfer_mount_name}   /opt/vmware/vcloud-director/data/transfer    nfs     rw,vers=3,rsize=32768,wsize=32768,hard,timeo=600  0 0" >> /etc/fstab
mount -a
#systemctl stop firewalld
#systemctl disable firewalld

gsutil cp ${bucket_url}/${vcd_binary_filename} /tmp/
gsutil cp ${bucket_url}/${vcd_keystore_filename} /tmp/
gsutil cp ${bucket_url}/responses.properties /tmp/

chmod +x /tmp/${vcd_binary_filename}
echo "N" | /tmp/${vcd_binary_filename}

instance_ip=$(/sbin/ip -o -4 addr list eth0 | awk '{print $4}' | cut -d/ -f1)

/opt/vmware/vcloud-director/bin/configure -r /tmp/responses.properties -ip $instance_ip --primary-port-http 80 --primary-port-https 443 -cons $instance_ip --console-proxy-port-https 8443 --keystore /tmp/${vcd_keystore_filename} -w "${vcd_keystore_filename_password}"  --enable-ceip true -unattended

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

sed -i "s/Xms1024M/Xms2048M/g" /opt/vmware/vcloud-director/bin/vmware-vcd-cell-common
sed -i "s/Xmx4096M/Xmx6144M/g" /opt/vmware/vcloud-director/bin/vmware-vcd-cell-common

service vmware-vcd start