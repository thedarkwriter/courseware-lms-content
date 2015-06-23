include lms
file {'/etc/puppetlabs/puppet/environments':
  ensure  => directory,
  source  => 'puppet:///modules/lms/infrastructure/environments',
  recurse => true,
}
