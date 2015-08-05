class data_types::block_resource {
  
  File {
      mode   => '644',
      ensure => file,
  }

  file {
    "/etc/apache.conf.d/main_website.conf":
      content => template("data_types/main_website.conf.erb"),
      ;
    "/etc/apache.conf.d/reports.conf":
      content => template("data_types/reports.conf.erb"),
      ;
    "/etc/apache.conf.d/admin_site.conf":
      content => template("data_types/admin_site.conf.erb"),
      ;
  }
}
