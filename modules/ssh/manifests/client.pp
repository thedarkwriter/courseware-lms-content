# == Class: ssh::client
#
class ssh::client {
  File {
    owner => 'root',
    group => 'root',
  }

  $client_package = $ssh::params::ssh_client_package
  $ssh_config     = $ssh::params::ssh_config

  package { $client_package:
    ensure => installed,
  }

  file { $ssh_config:
    ensure => file,
    mode   => '0644',
    source => "puppet:///modules/ssh/${::osfamily}-client",
  }

}
