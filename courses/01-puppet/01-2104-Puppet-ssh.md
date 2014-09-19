# Managing SSH Keys

This course demonstrates how to use a Puppet Module to manage SSH client and server keys in your environemnt.  

At the end of this course you will be able to:

* Install the saz-ssh module from the Puppet Forge.
* Add the ssh classes to nodes in your infrastructure. 

## Slide Content

### slide 1
This course is a quick look at how to use Puppet Enterprise to manage SSH key authentication. 


### slide 2
We'll look at how to install an SSH module from the Puppet Forge, add the ssh classes to a node group, and set some parameters included in the SSH module. 
### slide 3
First -  a quick review of SSH. Secure Shell (SSH) is a protocol that enables encrypted connections between nodes on a network for secure data communication, remote command-line login, remote command execution, and other secure network services. Perhaps the most common application of the protocol is for access to shell accounts on Unix-like operating systems, but it can also be used in a similar fashion for accounts on Windows.  

### slide 4SSH uses public-key cryptography to authenticate clients and servers.  During authentication, the client and server prove their identities to each other by using private and public key pairs. These public and private key pairs work in concert. Something encrypted with the private key can be decrypted with the public key, and the reverse.

On a Linux system, the authorized keys file lists the public keys that are permitted to log in.  When the user logs in, the ssh client presents, to the server, a secret computed using the private half of its key pair for the server to use for authentication. The server validates that secret by performing the same computation in reverse, using the public key stored in the authorized keys file.

Key-based authentication is the most secure of several modes of authentication, including passwords. If you use public-key authentication, in order to access your system, an attacker needs a copy of a private key corresponding to a public key stored on the server.
 

### slide 5
Typically, the first time you attempt to SSH into a host you’ve never connected to before, you receive a message similar to this one. If you select yes, the public key for that host is added to your SSH known_hosts file, and you won’t have to authenticate it again unless that host’s key changes.

### slide 6
If you strongly care about authentication, you can use Puppet Enterprise to automate management of your SSH client and server authentication keys. 

### slide 7
The saz-ssh module, available on the Puppet Forge, is one of many modules written by members of our user community and available for download. You can use the saz-ssh module to automate management of your ssh keys. To install the saz ssh module, from the Puppet Master, run the command puppet module install saz-ssh.  As simple as that, you have installed the saz-ssh module. All of the classes included in the module are available for you to assign to agent nodes.

### slide 8
A Puppet class is a collection of resources that are managed together as a single unit. You can think of them as blocks of Puppet code. The saz-ssh module includes classes for managing the client and server ssh authentication keys. Some of these classes are: The main class, ssh, that you declare in order to configure the behavior of the module. The ssh class includes a number of additional classes:  The ssh client and server classes manage installation and configuration ssh clients and servers. And some of the other classes manage hostkeys and knownhosts.

### slide 9
Now that the ssh module is installed, you can use the Puppet Enterprise Console to apply the ssh class to  a group of nodes in your infrastructure.  On the left panel of the console, Click Add Classes, and then search for and add the class to the environment. 

### slide 10
Next, select a group and navigate to the group page. Then select Edit, and search for and add the ssh class to your group. 

### slide 11
And the last step is to navigate to the Live Management page, and select runonce. During this run, the first server that runs shares its key. Then select runonce for a second time. During this run, The server collects keys from the other agents. 

### slide 12
After you install the ssh module and run Puppet, Puppet Enterprise can collect the public keys for the agent nodes and distribute the public keys to the known_hosts files of the other agent nodes in the group. Then in the future, users will not be asked to authenticate when they use SSH. The process is automated.

### slide 13
With Puppet Enterprise you can edit or add class parameters from the PE console which means you don't have to edit the module code directly. The saz-ssh module, by default, allows root login over SSH. But what if want to limit root access on some agent nodes? You can easily change this parameter. From the console, select the node group that you want to change, and then select Edit. Find SSH in the class list, and click Edit Parameters.  

### slide 14
On the ssh parameters dialog box, in the server_options parameter field, enter the value: {"PermitRootLogin"=>"no"}. The grey text that appears in some fields represents default values which you can restore by clicking the reset buttons. After making changes, launch a Puppet run so that Puppet Enterprise can apply the new configuration.  

### slide 15
You can find more information about the saz ssh module and other Puppet modules on the puppet forge.

### slide 16
In this brief course, we looked at how to install an ssh Puppet module from the Puppet Forge, how to add classes from the module to node groups, and how to edit class parameters.   

### slide 17
To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.

### slide 18
Thank you for completing this Puppet Labs Workshop course.



## Quiz
1. True or False. 
2. Which ?  
	a. .
	b. **xxx**
	c. .
	d. .
3. Which ?  
	a. .
	b. **xxx**
	c. .
	d. .
4. Which ?  
	a. .
	b. **xxx**
	c. .
	d. .
5. True or False. 
	**True**

## References
* [Vim Documentation](http://www.vim.org/docs)
* [Vim Blog](http://puppetlabs.com/blog/vim-tool-for-learning-puppet)
