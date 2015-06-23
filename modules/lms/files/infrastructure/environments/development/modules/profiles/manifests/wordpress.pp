class profile::wordpress {
  include apache
  include apache::mod::php
  package { '':
    ensure => present,
  }
  apache::vhost { $::fqdn:
    port     => '80',
    priority => '00',
    docroot  => '/var/www/html',
  }
  class { '::wordpress':
    install_dir    => '/var/www/html',
    db_name        => 'wordpress',
    db_user        => 'wordpress',
    db_password    => 'wordpress',
    db_host        => '',
    create_db      => false,
    create_db_user => false,
    require        => Class['apache','profile::base']
  }
}
