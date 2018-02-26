Once the software packages are installed on the proper servers, the runbook instructs us to modify certain files to configure the software. The database servers must be configured in a primary/secondary configuration. NOTE: For the sake of simplicity, not every required PostgreSQL parameter will be configured.

The db1 server needs the following line added to its /var/lib/pgsql/data/postgresql.conf file:

`listen_addresses = '192.168.0.10'`

The db2 server needs the following line added to its  /var/lib/pgsql/data/postgresql.conf file:

`primary_conninfo = 'host=192.168.0.10 port=5432 user=replication password=password'`

Puppet can see a variety of attributes about a file or any resource type. Some examples of other attributes might include **mode**, **ensure**, **owner**, or **group**. The <code>puppet resource</code> command shows you all the attributes Puppet knows about a resource, as well as their values. This is useful for identifying and examining the contents of any given file.

## Task:
Enter the <code>puppet resource</code> command to see all the attributes of the <code>file</code> at <code>/etc/motd</code>.

<p><iframe src="https://magicbox.whatsaranjit.com/syntax/querying_the_system" width="100%" height="500px" frameborder="0" /></iframe></p>

The web1, web2 and web3 servers need the following line added to /etc/robby/robby.cfg:

welcome_msg = Welcome to Robby, running on ``<hostname>!``

``<hostname>`` indicates a location where the actual hostname of the server being configured must be inserted into the string. When writing Puppet code, you use facts to retrieve information about the server that you are configuring. The fqdn fact contains the fully-qualified domain name for the server that is being configured. This fact might have the value of web1, web3, db1, etc. depending on the machine that is being configured.

Now you will create the robby.cfg file with the proper content shown above using a file resource.

## Task:
<p><iframe src="https://magicbox.whatsaranjit.com/syntax/modifying_attributes" width="100%" height="500px" frameborder="0" /></iframe></p>

<p>You&#39;ve just changed the attributes of a file. Now use the <code>puppet resource</code> command again to see how the attributes of the file look. You&#39;ll notice that the mode attribute is now the new value of 0600 instead of 0644.</p>

<p>Look up the mode attribute of the file to see its new value and how it has changed since you last ran this command. Use the <code>puppet resource</code> command to inspect the <code>file</code> at <code>/etc/motd</code>. </p>

The HAProxy load balancer must also be configured by adding the following lines to the /etc/haproxy/haproxy.cfg file: {{THIS GOES}}

```listen http-in
    bind *:80
    server web1 192.168.0.1:8000 maxconn 32
    server web2 192.168.0.2:8000 maxconn 32
    server web3 192.168.0.3:8000 maxconn 32```

Notice that as you are developing your Puppet source code, you have multiple resources that will be applied to each of the servers. Since the runbook specified the steps in a certain order, it's important to make sure that Puppet applies changes to your servers in the same order. This can be achieved with resource relationships.
