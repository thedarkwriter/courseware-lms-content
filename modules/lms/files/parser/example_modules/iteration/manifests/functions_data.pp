class iteration::functions {
  $websites = {
    'larrysblog.puppetlabs.vm' => {
      'owner' => 'larry',
      'docroot' => '/var/www/larry/',
      'publish' => true
    },
    'notcurly.puppetlabs.vm' => {
      'owner' => 'shemp',
      'docroot' => '/var/www/shemp/public/',
      'publish' => false
    },
    'moe.puppetlabs.vm' => {
      'owner' => 'moe',
      'docroot' => '/var/www/moe/blog/',
      'publish' => true
    },
    'theking.puppetlabs.vm' => {
      'owner' => 'elvis',
      'docroot' => '/var/www/elvis/',
      'publish' => false
    }
  }
}
