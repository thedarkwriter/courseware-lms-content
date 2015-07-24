class puppet_templates::epp {
  file { '/etc/motd':
    content => epp("puppet_templates/motd.epp", { 
      'student_name' => "Enter your name",
      }),
  }
}
