#!/bin/bash

rm -f /EMPTY
sed -i 's/:wq//' /etc/puppetlabs/puppet/puppet.conf
rm -rf /labs
