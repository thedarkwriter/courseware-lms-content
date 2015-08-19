class iteration::each_data {
  $users = ['larry','moe','shemp','elvis']

  $websites = {
    "larrysblog.puppetlabs.vm" => {
      "docroot" => "/var/www/larry/",
      "publish" => true
    },
    "notcurly.puppetlabs.vm" => {
      "docroot" => "/var/www/shemp/public/",
      "publish" => false
    }
    "moe.puppetlabs.vm" => {
      "docroot" => "/var/www/moe/blog/",
      "publish" => true
    }
    "theking.puppetlabs.vm" => {
      "docroot" => "/var/www/elvis/",
      "publish" => false
    }
  }
}
