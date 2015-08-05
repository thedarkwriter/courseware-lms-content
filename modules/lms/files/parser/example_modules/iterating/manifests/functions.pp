class iteration::functions {
  $websites = {
    'larrysblog.puppetlabs.vm' => {
      'owner' => 'larry',
      'docroot' => '/var/www/larry/',
      'publish' => true
    },
    'notcurly.puppetlabs.vm' => {
      'owner' => 'shemp',
      'docroot' => '/var/www/shemp/public/',
      'publish' => false
    },
    'moe.puppetlabs.vm' => {
      'owner' => 'moe',
      'docroot' => '/var/www/moe/blog/',
      'publish' => true
    },
    'theking.puppetlabs.vm' => {
      'owner' => 'elvis',
      'docroot' => '/var/www/elvis/',
      'publish' => false
    }
  }

  $published_sites =
  $users = 
  $user_list =

  $users.each |$user| {
    file { "/var/www/${user}":
      ensure => file,
      owner  => ${user},
    }
    file { "/home/${user}/www":
      ensure  => link,
      target  => "/var/www/${user}",
      require => File["/var/www/${user}"]
    }
  }
  
  $published_sites.each |$site_fqdn, $site_info| {
    nginx::vhost { $site_fqdn:
      www_root => $site_info["docroot"],
    }
  }

  file { "/var/www/user_list.txt":
    ensure  => file,
    content => $user_list,
  }
}
