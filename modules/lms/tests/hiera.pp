class { 'lms': 
  course => 'hiera' 
}
# Remove the timeout and warning message
file { '/etc/profile.d/profile.sh':
  ensure => absent,
}
