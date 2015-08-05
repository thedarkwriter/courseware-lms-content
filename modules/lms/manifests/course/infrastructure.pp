class lms::course::infrastructure {
  file {"${lms::code_dir}/environments":
    ensure  => directory,
    source  => 'puppet:///modules/lms/infrastructure/environments',
    recurse => true,
  }
}
