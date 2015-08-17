class iteration::each (
  $websites = $iteration::each_data::websites
) inherits iteration::each_data {
  include nginx
  nginx::resource::vhost { "larrysblog.puppetlabs.vm":
    www_root => $websites["larrysblog.puppetlabs.vm"]["docroot"],
  }
}
