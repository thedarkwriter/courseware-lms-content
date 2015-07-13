#!/bin/bash

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

# Hide all output from the puppet run
puppet agent -t >/dev/null 2>/dev/null
