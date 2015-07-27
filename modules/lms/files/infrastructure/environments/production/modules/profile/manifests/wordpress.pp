class profile::wordpress {
    class { 'mysql::server':
        root_password => 'supersekrit',
    }
    class { 'mysql::bindings':
        php_enable => true,
    }

    include apache
    include apache::mod::php
    apache::vhost { $::fqdn:
        port     => '80',
        priority => '00',
        docroot  => '/var/www/html',
    }

    class { '::wordpress':
        install_dir => '/var/www/html',
        require     => Class['apache'],
    }
}
