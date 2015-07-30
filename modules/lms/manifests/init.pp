class lms ($course = 'default') {
  $codedir = versioncmp('4.0.0',$puppetversion) ? {
    1       => '/etc/puppetlabs/puppet',
    default => '/etc/puppetlabs/code'
  }
  include lms::hiera_files
}
