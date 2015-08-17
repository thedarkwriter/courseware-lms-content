class iteration::functions (
  $websites = $iteration::functions_data::websites
) inherits iteration::functions_data {

  $published_sites = $websites.filter |$site_fqdn, $site_info| { #Your code goes here }
  $users = $websites.map |$site_fqdn, $site_info| { #Your code goes here } 
  $user_list = $users.reduce |$memo, $user| { #Your code goes here }

  $users.each |$user| {
    file { "/var/www/${user}":
      ensure => file,
      owner  => $user,
    }
    file { "/home/${user}/www":
      ensure  => link,
      target  => "/var/www/${user}",
      require => File["/var/www/${user}"]
    }
  }
  
  include nginx
  $published_sites.each |$site_fqdn, $site_info| {
    nginx::resource::vhost { $site_fqdn:
      www_root => $site_info["docroot"],
    }
  }

  file { "/var/www/user_list.txt":
    ensure  => file,
    content => "The following users have websites: ${user_list}",
  }
}
