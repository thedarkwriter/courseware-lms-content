class lms::course::parser {
  include lms
  file { "$settings::codedir/modules":
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///modules/lms/parser/example_modules',
  }
}
