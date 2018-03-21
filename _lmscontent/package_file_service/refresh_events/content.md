You have seen ways to edit an application's configuration file before you start its service. But what if you need to make a change to a service that is already running? Most software requires a restart or reload after you edit the configuration file for that change to take effect. Puppet allows you to **refresh** a resource using the `subscribe` or `notify` attributes.

Puppet provides the `notify` and `subscribe` attributes to not only order resources, but send a **refresh**. Refreshing a resource means different things depending on the resource type.

For example, when you refresh a service resource type, Puppet restarts the service. And when you refresh a mount resource type, Puppet remounts a file mount.

You can try to refresh any type in Puppet, but not all of them will respond. Read the [Puppet docs](https://puppet.com/docs/puppet/latest/lang_relationships.html#refreshing-and-notification) for more information about refreshing and notification.

Example:

<pre>
package { 'postgresql-server':
  ensure =&gt; installed,
}

file { '/var/lib/pgsql/data/postgresql.conf':
  ensure  =&gt; file,
  content =&gt; '...',
  require =&gt; Package['postgresql-server']
}

service { 'postgresql':
  ensure    =&gt; running,
  subscribe =&gt; File['/var/lib/pgsql/data/postgresql.conf'],
}
</pre>

In this example, the `subscribe` attribute tells Puppet to manage the file resource before the service resource and to restart the service if the file resource changes. This can also be written like the following example:

<pre>
package { 'postgresql-server':
  ensure =&gt; installed,
  before =&gt; File['/var/lib/pgsql/data/postgresql.conf'],
}

file { '/var/lib/pgsql/data/postgresql.conf':
  ensure  =&gt; file,
  content =&gt; '...',
  notify  =&gt; Service['postgresql'],
}

service { 'postgresql':
  ensure    =&gt; running,
}
</pre>

This example uses the `notify` attribute instead of `subscribe` but the outcome is the same.

If you want to use `before` and also send a refresh, use `notify`. If you want to use `require` and also receive a refresh, use `subscribe`.

## Task:
Add `notify` or `subscribe` to the following code so that the service is restarted if the file resource is changed.

<iframe src="https://magicbox.classroom.puppet.com/pfs/file_service" width="100%" height="500px" frameborder="0"></iframe>

## Task:

Add `notify` or `subscribe` to the following code so the `postgresql` service resource is refreshed when the `postgresql.conf` file resource changes.

<iframe src="https://magicbox.classroom.puppet.com/scenario/file_service" width="100%" height="500px" frameborder="0"></iframe>
