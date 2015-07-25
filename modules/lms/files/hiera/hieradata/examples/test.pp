$site_users = hiera_hash("site_users")

notice('jane')
notice($site_users['jane'])

notice('jim')
notice($site_users['jim'])

notice('bob')
notice($site_users['bob'])

