class ssh::params {
  case $::osfamily {
    'RedHat': {
      $ssh_server_package = 'openssh-server'
      $ssh_client_package = 'openssh-clients'
      $ssh_service        = 'sshd'
      $sshd_config        = '/etc/ssh/sshd_config'
      $ssh_config         = '/etc/ssh/ssh_config'
    }
    'Debian': {
      $ssh_server_package = 'openssh-server'
      $ssh_client_package = 'openssh-clients'
      $ssh_service        = 'sshd'
      $sshd_config        = '/etc/ssh/sshd_config'
      $ssh_config         = '/etc/ssh/ssh_config'
    }
    default: {
      fail("${module_name} is not supported on ${::osfamily}.")
    }
  }
}
