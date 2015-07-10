class{'lms': course => 'default'}
file {'/root/labs/':
  ensure  => directory,
  recurse => true,
  source  => "puppet:///modules/lms/troubleshooting/labs",
}
file {'/usr/local/bin/':
  ensure  => directory,
  recurse => true,
  source  => "puppet:///modules/lms/troubleshooting/scripts/",
  mode    => 755,
}
file {'/root/.bashrc.puppet':
  ensure => absent,
}

