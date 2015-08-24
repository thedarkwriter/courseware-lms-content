# Normally this would use the aio_agent_version fact
# that is installed by the puppet_enterprise module
# since we're installing puppet-agent, we'll use this fact instead
$codedir = versioncmp('4.0.0',$puppetversion) ? {
  1       => '/etc/puppetlabs/puppet',
  default => '/etc/puppetlabs/code'
}
$ruby_binary = versioncmp('4.0.0',$puppetversion) ? {
  1       => '/opt/puppet/bin/ruby',
  default => '/bin/ruby'
}

file { "${codedir}/modules/lms/":
  ensure  => directory,
  source  => '/usr/src/courseware-lms-content/modules/lms/',
  recurse => true,
}
file { '/usr/local/bin/course_update':
  ensure  => file,
  mode    => '0755',
  source  => '/usr/src/courseware-lms-content/scripts/course_update.rb',
}
file { '/usr/local/bin/course_selector':
  ensure  => file,
  mode    => '0755',
  source  => '/usr/src/courseware-lms-content/scripts/course_selector.rb',
}
file { '/usr/local/bin/course_menu':
  ensure  => file,
  mode    => '0755',
  content  => template('/usr/src/courseware-lms-content/scripts/course_menu.rb.erb'),
}
