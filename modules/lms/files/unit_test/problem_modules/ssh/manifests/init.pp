# Implementing our SSH module
class ssh (
  $server = true,
  $client = true,
  ) inherits ssh::params {

  if $server {
    include ::ssh::server
  }

  if $client {
    include ::ssh::client
  }

}
