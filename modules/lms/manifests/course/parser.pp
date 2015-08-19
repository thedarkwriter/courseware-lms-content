class lms::course::parser {
  include lms
  file { '/root/puppetcode':
    ensure => directory,
  }
  file { '/root/puppetcode/modules':
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///modules/lms/parser/example_modules',
  }
  exec {'puppet module install jfryman-nginx --modulepath=/root/puppetcode/modules':
    path => '/usr/local/bin:/bin'
  }
}
