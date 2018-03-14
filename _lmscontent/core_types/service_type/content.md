This type manages services running on the node. Some important attributes include `name`, `ensure`, `enable`, `hasrestart`, and `hasstatus`.

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

<iframe src="https://magicbox.classroom.puppet.com/scenario/start_a_service" width="100%" height="500px" frameborder="0"></iframe>

As you develop Puppet source code, you will have multiple resources that will be applied to each of the servers. Since the runbook specified the steps to configure your servers in a certain order, it's important to ensure that Puppet applies changes to your servers in that same order. This can be achieved with resource relationships.
