class lms::course::unit_test {
  include lms
  file { "${settings::codedir}/modules":
    ensure  => directory,
    recurse => true,
    source  => 'puppet:///modules/lms/unit_test/problem_modules',
  }
  # Students install these packages during the course, so remove them here
  package { ['rspec-puppet','puppetlabs_spec_helper']:
    ensure => absent,
  }
}
