<pre><code># /etc/puppetlabs/puppet/modules/motd/manifests/init.pp
class motd {
  file { '/etc/motd':
    ensure  =&gt; file,
    owner   =&gt; 'root',
    group   =&gt; 'root',
    content =&gt; "Hello world! Welcome to ${hostname}. My IP address is ${ipaddress_eth0}.",
  }
}
</code></pre>