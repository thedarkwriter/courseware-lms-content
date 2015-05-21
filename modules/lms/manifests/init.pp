class lms ($course = 'default') {
  file { '/etc/puppetlabs/puppet/hiera.yaml':
    ensure => present,
    source => "puppet:///modules/lms/${course}/hiera.yaml",
  }
  file { '/etc/puppetlabs/puppet/hieradata/':
    ensure  => directory,
    recurse => true,
    purge   => true,
    source  => "puppet:///modules/lms/${course}/hieradata",
  }
}
