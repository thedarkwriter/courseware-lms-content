class debug_code1 {
  file { '/labs':
    ensure => directory,
  }
  file { '/labs/test_file.txt'
    ensure  => present,
    content => 'This is a test',
  }
}

include debug_code1
