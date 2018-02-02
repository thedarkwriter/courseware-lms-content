Run facter to gather a list of all known facts

<code>facter</code>

Run facter to determine the fqdn, the network interfaces, and the IP address for eth0

* <code>facter fqdn</code>
* <code>facter interfaces</code>
* <code>facter ipaddress_eth0</code>

The <code>/etc/motd</code> file is presented to users each time they log in. We would like to customize this login message to contain information about the current host.

Change your current working directory to your modulepath with

<code>cd /etc/puppetlabs/code/modules</code>

Examine the directory structure of the example motd module.

<pre><code>[root@training modules]# tree motd/
motd/
├── manifests
│   └── init.pp
├── Modulefile
├── README
├── spec
│   └── spec_helper.rb
└── tests
    └── init.pp</code></pre>
Update the motd module’s main class manifest file to set the content of your <code>/etc/motd</code> file to a message that includes the node’s <code>hostname</code> and <code>operatingsystem</code>. Please note that strings must use double quotes in order for variables to be interpolated.

<code>vim motd/manifests/init.pp</code>

Validate your syntax and enforce your class. and apply the class. Your <code>/etc/motd</code> file should contain the facts you specified.

* <code>puppet parser validate motd/manifests/init.pp</code>
* <code>puppet apply motd/tests/init.pp</code>