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

