exec { 'update repo':
  command => 'git pull',
  cwd     => '/usr/src/courseware-lms-content',
  path    => '/usr/bin:/bin'
}
file { '/etc/puppetlabs/puppet/modules/lms/':
  ensure  => directory,
  source  => '/usr/src/courseware-lms-content/modules/lms/',
  recurse => true,
  require => Exec['update repo']
}
file { '/usr/local/bin/course_selector':
  ensure  => present,
  mode    => 755,
  source  => '/usr/src/courseware-lms-content/scripts/course_selector.rb',
  require => Exec['update repo']
}
