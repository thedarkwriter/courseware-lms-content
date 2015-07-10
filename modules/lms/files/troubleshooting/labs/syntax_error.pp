class syntax_error {
  file { ['/labs','/labs/syntax']:
    ensure => directory,
  }
  file { '/labs/syntax/test_file.txt'
    ensure  => present,
    content => 'This is a test',
  }
}

include syntax_error
