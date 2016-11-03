#!/bin/bash -e

ctx logger debug "${COMMAND}"

sudo mkdir -p /etc/chronos

echo '
[http]
bind-address = $(hostname -I)
bind-port = 7253
threads = 50

[logging]
folder = /var/log/chronos
level = 2

[alarms]
enabled = true

[exceptions]
max_ttl = 600' | sudo tee --append /etc/chronos/chronos.conf


ctx logger info "Installing sprout packages and other clearwater packages"
sudo DEBIAN_FRONTEND=noninteractive apt-get install sprout-node --yes
sudo DEBIAN_FRONTEND=noninteractive apt-get install clearwater-snmpd --yes
ctx logger info "The installation packages is done correctly"

ctx logger info "Use the DNS server"
echo 'RESOLV_CONF=/etc/dnsmasq.resolv.conf' | sudo tee --append  /etc/default/dnsmasq
sudo service dnsmasq force-reload

ctx logger info "Installation is done"
