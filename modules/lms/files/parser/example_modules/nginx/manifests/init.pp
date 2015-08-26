class nginx {
  case $::osfamily {
    'redhat','debian' : {
      $package = 'nginx'
      $owner   = 'root'
      $group   = 'root'
      $docroot = '/var/www'
      $confdir = '/etc/nginx'
      $logdir  = '/var/log/nginx'             # new parameter
    }
    'windows' : {
      $package = 'nginx-service'
      $owner   = 'Administrator'
      $group   = 'Administrators'
      $docroot = 'C:/ProgramData/nginx/html'
      $confdir = 'C:/ProgramData/nginx'
      $logdir  = 'C:/ProgramData/nginx/logs'  # new parameter
    }
    default   : {
      fail("Module ${module_name} is not supported on ${::osfamily}")
    }
  }

  # user the service will run as. Used in the nginx.conf.erb template
  $user = $::osfamily ? {
    'redhat'  => 'nginx',
    'debian'  => 'www-data',
    'windows' => 'nobody',
  }

  File {
    owner => $owner,
    group => $group,
    mode  => 664,
  }

  package { $package:
    ensure => present,
  }

  file { "${confdir}/conf.d":
    ensure  => present,
    require => Package['nginx']
  }

  file { $docroot:
    ensure => directory,
  }
  
  file { "${docroot}/default":
    ensure => directory,
  }

  file { "${docroot}/default/index.html":
    ensure  => file,
    content => template('nginx/index.html.erb'),
  }
  
  file { "${confdir}/conf.d/default.conf":
    ensure  => file,
    content => template('nginx/default.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }
  
  file { "${docroot}/larry":
    ensure => directory,
  }

  file { "${docroot}/larry/index.html":
    ensure  => file,
    content => template('nginx/larry-index.html.erb'),
  }
  
  file { "${confdir}/conf.d/larry.conf":
    ensure  => file,
    content => template('nginx/larry.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }


  file { "${confdir}/nginx.conf":
    ensure  => file,
    content => template('nginx/nginx.conf.erb'),
    require => Package['nginx'],
    notify  => Service['nginx'],
  }

  service { 'nginx':
    ensure    => running,
    enable    => true,
  }
}

