# Normally this would use the aio_agent_version fact
# that is installed by the puppet_enterprise module
# since we're installing puppet-agent, we'll use this fact instead
$codedir = versioncmp('4.0.0',$puppetversion) ? {
  1       => '/etc/puppetlabs/puppet',
  default => '/etc/puppetlabs/code'
}
$puppet_base_dir = versioncmp('4.0.0',$puppetversion) ? {
  1       => '/opt/puppet',
  default => '/opt/puppetlabs/puppet'
}

exec { 'update repo':
  command => 'git pull',
  cwd     => '/usr/src/courseware-lms-content',
  path    => '/usr/bin:/bin'
}
file { "${codedir}/modules/lms/":
  ensure  => directory,
  source  => '/usr/src/courseware-lms-content/modules/lms/',
  recurse => true,
  require => Exec['update repo']
}
file { '/usr/local/bin/course_selector':
  ensure  => file,
  mode    => '0755',
  source  => '/usr/src/courseware-lms-content/scripts/course_selector.rb',
  require => Exec['update repo']
}
file { '/usr/local/bin/course_menu':
  ensure  => file,
  mode    => '0755',
  content  => template('/usr/src/courseware-lms-content/scripts/course_menu.rb.erb'),
  require => Exec['update repo']
}
