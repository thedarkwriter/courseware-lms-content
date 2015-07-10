class logical_error {
  file { ['/labs','/labs/logic']:
    ensure  => directory,
    require => File['/labs/test_file.txt'],
  }
  file { '/labs/logic/test_file.txt':
    ensure  => present,
    content => 'This is a test',
  }
}

include logical_error
