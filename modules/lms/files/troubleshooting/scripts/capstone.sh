#!/bin/bash

# Make sure stdlib is installed
puppet module install puppetlabs-stdlib --modulepath=/etc/puppetlabs/puppet/modules

# Set up a wonky site.pp
cat > /etc/puppetlabs/puppet/environments/production/manifests/site.pp << EOM
filebucket { 'main':
  server => 'learning.puppetlabs.vm',
  path   => false,
}

File { backup => 'main' }

node default {
  file_line { 'updates':
      path  => '/etc/puppetlabs/puppet/puppet.conf',
      line  => 'server = training.puppetlabs.vm',
      match => '^\s*server.*',
  }
}
EOM

echo "Setting up capstone scenario, please stand by."
# Hide all output from the puppet run
puppet agent -t >/dev/null 2>/dev/null
