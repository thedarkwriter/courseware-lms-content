class lms::course::smoke_test {
  include lms
  file { "${settings::codedir}/modules":
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///modules/lms/smoke_test/problem_modules',
  }
}
