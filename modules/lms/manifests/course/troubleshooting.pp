class lms::course::troubleshooting {
  include lms
  file {'/usr/local/bin/':
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///modules/lms/troubleshooting/scripts/',
    mode    => '0755',
  }
  file {'/root/.bashrc.puppet':
    ensure => present,
    source => 'puppet:///modules/lms/troubleshooting/bashrc.puppet',
  }
  file {'/root/.tmux.conf':
    ensure => absent,
  }
}
