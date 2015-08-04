class data_types::validation (
  $example_string = $data_types::params::example_string,
  $example_integer = $data_types::params::example_integer, 
  $example_bool = $data_types::params::example_bool,
  $example_array = $data_types::params::example_array,
  $example_hash = $data_types::params::example_hash,
) inherits data_types::params {
  if ! $example_bool {
    file {'/etc/motd':
      ensure  => file,
      content => $example_string
    }
    cron {'log_uptime':
      ensure  => present,
      command => '/bin/uptime > /var/log/uptime',
      user    => root,
      hour    => $example_integer,
    }
    user { $example_array:
      ensure      => present,
      managehome => false,
    }
    create_resources(package, $example_hash)
  }
}

