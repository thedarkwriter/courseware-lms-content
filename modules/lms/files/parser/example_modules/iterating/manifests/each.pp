class iterating::each {
  $users = ['larry','moe','shemp','elvis']

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

  nginx::vhost { "larrysblog.puppetlabs.vm":
    www_root => "/var/www/larry"
  }
}
