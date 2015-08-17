class iteration::each {
  $users = ['larry','moe','shemp','elvis']

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

  $websites = {
    "larrysblog.puppetlabs.vm" => {
      "docroot" => "/var/www/larry/",
      "publish" => true
    },
    "notcurly.puppetlabs.vm" => {
      "docroot" => "/var/www/shemp/public/",
      "publish" => false
    }
    "moe.puppetlabs.vm" => {
      "docroot" => "/var/www/moe/blog/",
      "publish" => true
    }
    "theking.puppetlabs.vm" => {
      "docroot" => "/var/www/elvis/",
      "publish" => false
    }
  }

  include nginx
  nginx::resource::vhost { "larrysblog.puppetlabs.vm":
    www_root => $websites["larrysblog.puppetlabs.vm"]["docroot"],
  }
}
