class { 'lms': 
  course => 'hiera' 
}
# Remove the timeout and warning message
file { '/etc/profile.d/profile.sh':
  ensure => absent,
}
# Remove auto-shutdown
file { '/etc/bash.bash_logout':
  ensure => absent,
}
