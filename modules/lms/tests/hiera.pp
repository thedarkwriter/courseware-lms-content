class { 'lms': 
  course => 'hiera' 
}
# Remove the timeout and warning message
file { '/etc/profile.d/profile.sh':
  ensure => present,
  source => 'puppet:///modules/lms/hiera/profile.sh'
}
# Remove auto-shutdown
file { '/etc/bash.bash_logout':
  ensure => absent,
}
