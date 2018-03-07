You have now practiced creating resource relationships between a package and a file, and then a file and service. Now put it all together in a common pattern called **Package File Service**.

This pattern tells Puppet to do the following:

1. First manage a **package** resource
2. Next manage a **file** resource
3. Finally manage a **service** resource

The service will also restart if the file resource contents change at all.

Look at the below example. You will use the three resources and add the resource relationships to model the Package File Service pattern.

<pre>
package { 'postgresl-server':
  ensure =&gt; installed,
}

file { '/var/lib/pgsql/data/postgresql.conf':
  ensure  =&gt; file,
  owner   =&gt; 'root',
  group   =&gt; 'root',
  mode    =&gt; '0644',
  content =&gt; "listen_addresses = '192.168.0.10'\n",
}

service { 'postgresl-server':
  ensure =&gt; running,
  enable =&gt; true,
}
</pre>

## Task:
Add resource relationships to the following code so that the resources are managed in the order of package, file, and service. The service should restart if the file resource is changed. You can choose between `before/require` and `notify/subscribe`.

<iframe src="https://magicbox.classroom.puppet.com/scenario/package_file_service" width="100%" height="500px" frameborder="0"></iframe>
