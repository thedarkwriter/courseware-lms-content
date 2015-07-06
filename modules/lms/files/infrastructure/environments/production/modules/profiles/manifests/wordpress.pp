class profile::wordpress {
  include apache
  include apache::mod::php
  package { 'php-mysql':
    ensure => present,
  }
  apache::vhost { $::fqdn:
    port     => '80',
    priority => '00',
    docroot  => '/var/www/html',
  }
  class { '::wordpress':
    install_dir    => '/var/www/html',
    require        => Class['apache','profile::base']
  }
}
