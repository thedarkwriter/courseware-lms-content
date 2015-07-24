class iterating::each {
  $users = ['larry','moe','shemp','elvis']

  $users.each |$user| {
    file { "/var/www/${user}":
      ensure => file,
      owner  => $user,
    }
    file { "/home/${user}/www":
      ensure  => link,
      target  => "/var/www/${user}",
      require => File["/var/www/${user}"],
    }
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

  $websites.each |$site_fqdn, $site_info| {
    if $site_info["publish"] {
      nginx::vhost { $key:
        www_root => $site_info["docroot"]
      }
    }
  }
}
