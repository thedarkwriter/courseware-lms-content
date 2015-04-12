# == Class: ssh::server
#
class ssh::server {
  File {
    owner => 'root',
    group => 'root',
  }

  $package     = $ssh::params::ssh_server_package
  $service     = $ssh::params::ssh_service
  $sshd_config = $ssh::params::sshd_config

  package { $package:
    ensure => installed,
  }

  file { $sshd_config:
    ensure => file,
    mode   => '0600',
    source => "puppet:///modules/ssh/${::osfamily}-server",
  }

  service { $service:
    ensure => running,
    enable => true,
  }

}
