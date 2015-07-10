#!/bin/bash

rm -f /EMPTY
sed -i .bak 's/:wq//' /etc/puppetlabs/puppet/puppet.conf
rm -rf /labs
