#!/bin/bash

rm -f /EMPTY
sed -i 's/:wq//' /etc/puppetlabs/puppet/puppet.conf
rm -rf /labs

cat > /etc/puppetlabs/puppet/environments/production/manifests/site.pp << EOM
filebucket { 'main':
  server => 'learning.puppetlabs.vm',
  path   => false,
}

File { backup => 'main' }

node default {
}
EOM
sed -i 's/training.puppetlabs.vm/learning.puppetlabs.vm/' /etc/puppetlabs/puppet/puppet.conf
