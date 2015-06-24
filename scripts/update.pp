exec { 'update repo':
  command => 'git pull',
  cwd     => '/usr/src/courseware-lms-content',
  path    => '/usr/bin:/bin'
}
include lms::lab_repo
include lms::course_selector
