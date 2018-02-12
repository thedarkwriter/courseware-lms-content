#!/bin/bash

declare -x OS_VERSION=`sw_vers -productVersion`
declare -x PE_VERSION='2017.3.4'

# Install Puppet if IT's version is missing
if ! test -x /opt/puppetlabs/puppet/bin/puppet ; then
  echo 'Puppet is missing installing it'
  curl -v -L \
    "https://s3.amazonaws.com/puppet-agents/${PE_VERSION}/puppet-agent/5.3.4/repos/apple/${OS_VERSION}/PC1/x86_64/puppet-agent-5.3.4-1.os${OS_VERSION}.dmg" \
    -o /tmp/puppet.dmg
  hdid /tmp/puppet.dmg
  sudo installer -pkg /Volumes/puppet-agent-*/puppet-agent-*.pkg -target /
else
  echo 'Found puppet installed.' 
fi

# Install Ruby preqs

sudo /opt/puppetlabs/puppet/bin/gem install bundle
/opt/puppetlabs/puppet/bin/bundle install

# Install modules
/opt/puppetlabs/puppet/bin/r10k puppetfile install -v debug2

sudo /opt/puppetlabs/puppet/bin/puppet apply --debug --trace --modulepath modules <<EOF

class {'homebrew':
  user => $LOGNAME,
}

include xcode

exec {'/usr/bin/xcode-select --install':
  require => Class['xcode'],
  unless  => '/usr/bin/xcode-select --install 2>&1 | grep already',
}

package { ['rbenv']:
  ensure   => present,
  provider => 'brew',
  require  => Class['xcode'],
}

EOF

eval "$(rbenv init -)"

yes y | rbenv install 2.2.5

git clone git@github.com:puppetlabs/courseware-lms-content.git /tmp/courseware-lms-content

cd /tmp/courseware-lms-content/_lmscontent

rbenv shell 2.2.5

bundle install


