#!/bin/bash -e

ctx logger debug "${COMMAND}"

ctx logger info "Installing homestead packages and other clearwater packages"
set +e
sudo DEBIAN_FRONTEND=noninteractive apt-get install homestead-node clearwater-prov-tools --yes
sudo DEBIAN_FRONTEND=noninteractive apt-get install clearwater-snmpd --yes
set -e
sudo sed -i '47d' /etc/monit/conf.d/clearwater-cassandra.monit
ctx logger info "The installation packages is done correctly"

ctx logger info "Use the DNS server"
echo 'RESOLV_CONF=/etc/dnsmasq.resolv.conf' | sudo tee --append  /etc/default/dnsmasq
sudo service dnsmasq force-reload

ctx logger info "Installation is done"
