class lms::hiera_files {
  file { "${lms::codedir}/hiera.yaml":
    ensure => present,
    source => "puppet:///modules/lms/${lms::course}/hiera.yaml",
  }
  file { "${lms::codedir}/hieradata/":
    ensure  => directory,
    recurse => true,
    purge   => true,
    source  => "puppet:///modules/lms/${lms::course}/hieradata",
  }
}
