class profile::mysqldb {
  class { 'mysql::server':
    root_password => 'supersekrit',
  }
  mysql::db {'wordpress':
    user     => 'wordpress',
    password => ,
    host     => 'localhost',
    grant    => ['ALL']
  }
  mysql_grant { 'wordpress@%/*.*':
    ensure     => 'present',
    options    => ['GRANT'],
    privileges => ,
    table      => '*.*',
    user       => 'wordpress@%',
  }
  mysql_user { 'wordpress@%':
    ensure   => 'present',
    password_hash => mysql_password('wordpress')
  }
}
