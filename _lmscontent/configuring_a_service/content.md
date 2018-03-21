Once the software packages are installed on the proper servers, the runbook instructs us to modify certain files to configure the software. 

But first, let's learn a little more about how Puppet manages files. Puppet can see a variety of attributes about a file or any resource type. Some examples of other file attributes might include **mode**, **ensure**, **owner**, or **group**. The `puppet resource` command shows you all the attributes Puppet knows about a resource, as well as their values.

## Task:

Enter the `puppet resource` command to see all the attributes of the `file` at `/etc/motd`.

<p><iframe src="https://magicbox.classroom.puppet.com/syntax/querying_the_system" width="100%" height="500px" frameborder="0"></iframe></p>

Now let's move on to configuring the software packages that have been installed on our servers. To start, the database servers must be configured in a primary/secondary configuration. 

**NOTE:** For the sake of simplicity, not every required PostgreSQL parameter will be configured.

Add the following line to `/var/lib/pgsql/data/postgresql.conf` on db1.mycorp.com:

`listen_addresses = '192.168.0.10'`

The file should be owned by `root`, group set to `root` and with `0644` permissions.

## Task:
<p><iframe src="https://magicbox.classroom.puppet.com/scenario/create_db1_postgresql_conf" width="100%" height="500px" frameborder="0"></iframe>
</p>

Add the following line to `/var/lib/pgsql/data/postgresql.conf` on db2.mycorp.com:

`primary_conninfo = 'host=192.168.0.10 port=5432 user=repl password=xyzzy'`

The file should be owned by `root`, group set to `root` and with `0644` permissions.

## Task:
<p><iframe src="https://magicbox.classroom.puppet.com/scenario/create_db2_postgresql_conf" width="100%" height="500px" frameborder="0"></iframe>
</p>

The web1.mycorp.com server needs the following line placed in the file `/etc/robby/robby.cfg`:

`welcome_msg = Welcome to Robby, running on HOSTNAME!`

*HOSTNAME* indicates where the actual hostname of the server being configured must be inserted into the string. When writing Puppet code, you use Puppet **facts** to retrieve information about the server that you are configuring. 

The `fqdn` fact contains the fully-qualified domain name for the server that is being configured. This fact might have the value of `web1.mycorp.com`, `web2.mycorp.com`, `db1.mycorp.com`, etc. depending on the machine that is being configured.

Next, you will create the `robby.cfg` file with the proper content shown above using a file resource. But in order to do that, first you need to learn more about facts.
