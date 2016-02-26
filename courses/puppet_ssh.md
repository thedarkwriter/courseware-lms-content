# Managing SSH Keys

Secure Shell (SSH) is a protocol that enables encrypted connections between nodes on a network. This course demonstrates how to use a Puppet Module to manage SSH client and server keys in your environment.  

At the end of this course you will be able to:

* Install the saz-ssh module from the Puppet Forge.
* Add the ssh classes to nodes in your infrastructure.
* Edit ssh class parameters. 

## Slide Content

### slide 1
This course is a quick look at how to use Puppet Enterprise to manage SSH key authentication. 


### slide 2
We'll look at how to install an SSH module from the Puppet Forge, add the ssh classes to a node group, and set ssh class parameters.  
### slide 3
First - a quick review of SSH. Secure Shell (SSH) is a protocol that enables encrypted connections between nodes on a network for secure data communication, remote command-line login, remote command execution, and other secure network services. Perhaps the most common application of the protocol is for access to shell accounts on Unix-like operating systems, but it can also be used in a similar fashion for accounts on Windows.    

### slide 4SSH uses public-key cryptography to authenticate clients and servers.  During authentication, the client and server prove their identities to each other by using private and public key pairs that work in concert. Information encrypted with the private key can be decrypted with the public key, and vice versa.

### slide 5
On a Linux system, the authorized keys file lists the public keys that are permitted to log in.  When the user logs in, the ssh client uses the private half of its key pair to create an encrypted message, which it sends to the server for authentication. The server validates the encrypted message, using the public key stored in the authorized keys file. 

### slide 6
Key-based authentication is the most secure of several modes of authentication, including passwords because in order to gain access to your system an attacker must have a copy of your private key that corresponds to the public key stored on the server. 


### slide 7
Typically, the first time you attempt to SSH into a host you’ve never connected to before, you receive a message similar to this one. If you select yes, the public key for that host is added to your SSH `known_hosts` file, and you won’t have to authenticate it again unless that host’s key changes. Note that if the host key changes, it could indicate that it has been compromised by an attacker.

### slide 8
You can use Puppet Enterprise to automate management of SSH authentication for the nodes in your environment.  

### slide 9
The saz-ssh module, available on the Puppet Forge, is one of many modules written by members of our user community and available for download. You can use this module to automate management of your ssh keys. To install the module, from the Puppet Master, run the command `puppet module install saz-ssh`.  As simple as that, you have installed the saz-ssh module. All of the classes included in the module are available for you to assign to agent nodes.

### slide 10
A Puppet class is a collection of resources that are managed together as a single unit. You can think of them as blocks of Puppet code. The saz-ssh module includes classes for managing the client and server SSH authentication keys.  The main class, `ssh`, is declared in order to configure a node as both an SSH client and server. Additional classes in the module (`ssh::client` and `ssh::server`) manage installation and configuration of nodes that function only as SSH clients and only as SSH servers, respectively. Finally, the `ssh::server::host_key` class manages server host keys.

### slide 11
Now that the saz-ssh module is installed, you can use the Puppet Enterprise Console, first to add the ssh class to your environment, and then to apply the ssh class to a group of nodes in your infrastructure.   

### slide 12
Although you have added the ssh classes to your node group, you need to initiate a Puppet run in order to share the SSH keys between nodes. On the Live Management page, select the Control Puppet tab. Then select the runonce action.  During the initial run, each node shares its key, but is not yet able to collect the keys from other nodes. Select the runonce option again so that all keys can be collected and installed into the `known_hosts` file on each node.   

### slide 13
After you install the saz-ssh module and run the Puppet agent on each node, Puppet collects the public keys from each node and distributes them to the `known_hosts` files of the other nodes in the group. Then in the future, users will not be asked to authenticate when they use SSH because Puppet has automated the process of distributing SSH host keys.

### slide 14
With Puppet Enterprise you can edit or add class parameters from the Puppet Enterprise console which means you don't have to edit the module code directly. For example, by default, the saz-ssh module allows root login over SSH. You may want to limit root access. To easily change this parameter from the console, select the node group that you want to change, then select the class that you want to edit, and then select Edit Parameters. For our ssh class example, on the parameters dialog box, in the server_options parameter field, enter the value: `{"PermitRootLogin"=>"no"}`. Then launch a Puppet run so that Puppet Enterprise can apply the new configuration. 

### slide 15
You can find more information about the saz-ssh module and other Puppet modules on the Puppet Forge.  

### slide 16
In this brief course, we looked at how to install an ssh Puppet module from the Puppet Forge, how to add classes from the module to node groups, and how to edit class parameters.  

### slide 17
To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.

### slide 18
Thank you for completing this Puppet Labs Workshop course.





## Quiz
1. True or False. 
	A Puppet class is a collection of resources that are managed together as a single unit.
	**True**
2. The main class in the saz-ssh module is:  
	a. ssh::server::host_key
	b. ssh::server
	c. ssh::host
	d. **ssh**
3. The main saz-ssh class is declared in order to:  
	a. **Configure a node as both an SSH client and an SSH server.**
	b. Manage installation of SSH server hosts.
	c. Install and configure SSH authentication keys.
	d. Restrict access to SSH keys.
4. After you install the saz-ssh module, you need to:  
	a. Install SSH keys on all nodes in your infrastructure.
	b. Instruct all users to force a Puppet run on their individual nodes.
	c. Distribute public and private keys for all nodes, and add the keys to the hosts file.
	d. **Add the SSH class to your environment, and apply the SSH class to a group of nodes.**.
5. True or False.
	With Puppet Enterprise, you can edit and add class parameters from the Puppet Enterprise console. 
	**True**

## References
* [saz-ssh Module](https://forge.puppetlabs.com/saz/ssh)
* [Puppet Labs SSH Quick Start Guide](https://docs.puppetlabs.com/pe/latest/quick_start_ssh.html)
* [Accessing the Puppet Enterprise Console](https://docs.puppetlabs.com/pe/latest/console_accessing.html)
