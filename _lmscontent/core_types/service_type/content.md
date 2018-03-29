This resource type manages services running on the node. Some important attributes include `name`, `ensure`, `enable`, `hasrestart`, and `hasstatus`.

In the following example, the `sshd` service (SSH server) will be started and enabled to automatically restart after a reboot.

<pre>
service { 'sshd':
  ensure => running,
  enable => true,
}
</pre>

## Task:

Enter the `puppet resource` command to see all the attributes of the `service` named `puppet`.

<iframe src="https://magicbox.classroom.puppet.com/resources/exploring_service" width="100%" height="500px" frameborder="0"></iframe>

## Task:

Now that you are more familiar with the `service` resource type, update the following code so the `robby` service starts on the web1.mycorp.com server.

<iframe src="https://magicbox.classroom.puppet.com/scenario/start_robby_service" width="100%" height="500px" frameborder="0"></iframe>

As you develop Puppet source code, you will write multiple resources to be applied to a specific server. Since the runbook specified the steps to configure each server in a certain order, it's important to ensure that Puppet applies changes to a single server in that same order.

For instance, we don't want to try starting the `robby` service before the configuration file has been update. This can be achieved with **resource relationships**.

> **Pro Tip:**

> Resource relationships control the order that Puppet applies changes on a **single server** not across multiple servers.
