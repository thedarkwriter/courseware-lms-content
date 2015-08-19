class iteration::each (
  $users    = $iteration::each_data::users
  $websites = $iteration::each_data::websites
) inherits iteration::each_data {

  include nginx
  
  user { "larry":
    ensure     => present,
    managehome => true,
  }
  file { "/var/www/larry":
    ensure => file,
    owner  => 'larry',
  }
  file { "/home/larry/www":
    ensure  => link,
    target  => "/var/www/larry",
    require => File["/var/www/larry"],
  }

  nginx::resource::vhost { "larrysblog.puppetlabs.vm":
    www_root => $websites["larrysblog.puppetlabs.vm"]["docroot"],
  }
}
