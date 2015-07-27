class profile::base {
  # Resource declaration
  # This doesn't really merit the creation of a new class,
  # but it could grow to the point where a class that
  # manages these (or one class each) could be used instead.
  # The emphasis is on iterating quickly.
  # Ensure that the packages wget and vim-common are installed:
  package { ['wget', 'vim-common']:
    ensure => 
  }

  # Class declaration using include
  # use appropriate syntax to declare the class
  # logrotate::base
  include 
  include classroom::agent::hosts
  # Resource-like class declaration
  # Declare the appropriate class to manage SSH clients below:

  class { '':
  }

  # Using a defined type
  # Ensure that the logs are rotated every week

  logrotate::rule { 'messages':
    path         => '/var/log/messages',
    rotate       => 10,
    size         => '200k',
    shred        => true,
    rotate_every => '',
    postrotate   => '/usr/bin/killall -HUP syslogd',
  }
}
