exec { 'update repo':
  command => 'git pull',
  cwd     => '/usr/src/courseware-lms-content',
  path    => '/usr/bin:/bin'
}
file { '/etc/puppetlabs/puppet/modules/':
  ensure  => directory,
  source  => '/usr/src/courseware-lms-content/modules/',
  recurse => true,
  require => Exec['update repo']
}
file { '/etc/puppetlabs/puppet/hieradata/':
  source  => '/usr/src/courseware-lms-content/hiera/hieradata/',
  recurse => true,
  require => Exec['update repo']
}
file { '/etc/puppetlabs/puppet/hiera.yaml':
  source  => '/usr/src/courseware-lms-content/hiera/hiera.yaml',
  require => Exec['update repo']
}
file { '/usr/local/bin/course_selector':
  ensure  => present,
  mode    => 755,
  source  => '/usr/src/courseware-lms-content/scripts/course_selector.rb',
  require => Exec['update repo']
}
