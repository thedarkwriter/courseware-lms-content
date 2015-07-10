class debug_code2 {
  file { '/labs':
    ensure  => directory,
    require => File['/labs/test_file.txt'],
  }
  file { '/labs/test_file.txt':
    ensure  => present,
    content => 'This is a test',
  }
}

include debug_code2
