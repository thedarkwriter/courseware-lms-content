# An example ntp class for testing puppet-lint checks

class ntplint ($servers = undef, $enable = true, $ensure = running) {

  case $::operatingsystem {
    centos, redhat: {
      $service_name    = 'ntpd'
      $conf_template   = 'ntp.conf.el.erb'
      $default_servers = [
        '0.centos.pool.ntp.org',
        '1.centos.pool.ntp.org',
        ]
    }
    debian, ubuntu: {
      $service_name    = 'ntp'
      $conf_template   = 'ntp.conf.debian.erb'
      $default_servers = [
        '0.debian.pool.ntp.org iburst',
        '1.debian.pool.ntp.org iburst',
        ]
    }
    default: {
        fail('Unrecognized operating system')
    }
  }

  if $servers == undef {
    $servers_real = $default_servers
  }
  else {
    $servers_real = $servers
  }

  package { 'ntp':
    ensure => installed,
  }

  service { 'ntp':
    ensure    => $ensure,
    name      => $service_name,
    enable    => $enable,
    subscribe => File['ntp.conf'],
  }

  file { 'ntp.conf':
    ensure  => file,
    path    => '/etc/ntp.conf',
    require => Package['ntp'],
    content => template("ntp/${conf_template}"),
  }

}
