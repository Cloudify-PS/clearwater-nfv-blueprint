#!/bin/bash -e

ctx logger debug "${COMMAND}"

ctx logger info "Installing bono packages "
sudo DEBIAN_FRONTEND=noninteractive apt-get install bono-node restund --yes
sudo DEBIAN_FRONTEND=noninteractive apt-get install clearwater-snmpd --yes --force-yes
ctx logger info "The installation packages is done correctly"

ctx logger info "Configure a new DNS server"
echo 'RESOLV_CONF=/etc/dnsmasq.resolv.conf' | sudo tee --append  /etc/default/dnsmasq
sudo service dnsmasq force-reload
ctx logger info "Installation is done"
