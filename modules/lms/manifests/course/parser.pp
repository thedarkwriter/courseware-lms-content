class lms::course::parser {
  include lms
  file { "$settings::codedir/modules":
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///modules/lms/parser/example_modules',
  }
  exec {"puppet module install jfryman-nginx --modulepath=$settings::codedir/modules":
    path => '/usr/local/bin:/bin'
  }
}
