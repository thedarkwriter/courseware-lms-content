class lms::hiera_files {
  file { "${codedir}/hiera.yaml":
    ensure => present,
    source => "puppet:///modules/lms/${lms::course}/hiera.yaml",
  }
  file { "${codedir}/hieradata/":
    ensure  => directory,
    recurse => true,
    purge   => true,
    source  => "puppet:///modules/lms/${lms::course}/hieradata",
  }
}
