# Managing sudo Privileges

You can use Puppet to automate management of sudo privileges across your Puppet Enterprise deployment. 

After completing this course you will be able to:

* Download and install a sudo module from the Puppet Forge.
* Write a simple Puppet module to manage sudo privileges.


## Slide Content

### slide 1 - Title
Audio: In this course you will see how you can use Puppet to manage sudo privileges across your Puppet Enterprise deployment. 

### slide 2 - Objectives
Audio: We'll look at how to install a sudo module from the Puppet Forge, write a simple module to manage resources that set user privileges, and add classes from the modules to your agent nodes.

### slide 3
Audio: Sudo is a program for Unix-like computer operating systems that allows a permitted user to execute a command as the superuser or another user, as specified in the sudoers file. You use the /etc/sudoers file to define authorized users. In most cases, you want to manage sudo on your agent nodes to control which system users have access to elevated privileges. 

### slide 4
Audio: You can use a Puppet module to automate management of sudo privileges across your Puppet Enterprise deployment. The saz-ssh sudo module, available on the Puppet Forge, is one of many modules written by members of our user community and available for download. You should be aware that when you install this module, by default your current sudo config is purged. If this is not what you are expecting, you can see other usage options in the readme file on the forge website. To install the module, from the Puppet Master, run the command 'puppet module install saz-ssh'.  As simple as that, you have installed the saz-ssh module. All of the classes included in the module are available for you to assign to agent nodes.

### slide 5
Audio: Next you'll need to write a simple module that sets sudo privileges. First let's review the Puppet module structure. With Puppet Enterprise, the modules you use to manage nodes are located in the directory /etc/puppet/puppetlabs/modules - including modules installed by Puppet, modules you download from the Puppet Forge, and modules that you create. Puppet Enterprise also installs modules in the /opt/puppet/share/puppet/modules directory. You should not modify anything in or add any modules to this directory.

### slide 6
Audio: Modules are self-contained bundles of code and data. On disk, a module is a directory tree with a specific, predictable structure. The module name is the outermost directory’s name. One of the module subdirectories is the manifests directory. And the manifests directory contains all of the manifests in the module, including an init.pp manifest. The init.pp manifest must include a class with the same name as the module. Classes are named chunks of puppet code and are the primary means by which Puppet Enterprise configures nodes.

### slide 7
Audio: Now we are ready to write a module that contains a class that you can use to define and enforce a sudoers configuration across your Puppet Enterprise-managed infrastructure. We'll name the module "privileges," with a manifests directory and an init.pp manifest that includes the privileges class.

### slide 8
Audio: The Puppet code for this module looks like this. The user root resource ensures that the root user has a centrally defined password and shell. Puppet enforces this configuration, and reports on and remediates any drift detected, such as if an administrator unexpectedly logs in and changes the password on an agent node. The sudo :: conf "admins" resource creates a sudoers rule to ensure that members of the admin group have the ability to run any command using sudo. This resource creates a configuration fragment file to define this rule in /etc/sudoers.d/. And it it will be named 10_admins - the 10 being a default prefix. And the sudo::conf "wheel" resource creates a sudoers rule to ensure that members of the wheel group have the ability to run any command using sudo. This resource creates a configuration fragment to define this rule in /etc/sudoers.d/. It will be named 10_wheel.

### slide 9
Audio: And now you can use the Puppet Enterprise console to add the sudo and the privileges classes to the default node group, which contains all of the nodes in your deployment, including the Puppet Master. You also can add the classes to individual nodes or create your own groups. After you add the classes, you can navigate to the Live Management page, select the Control Puppet tab, and then click the runonce option to complete the process for enforcing a sudoers configuration across your Puppet Enterprise managed infrastructure.

### slide 10 - Resources and Quiz

To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.

### slide 15 - Thank you

Thank you for completing this Puppet Labs Workshop course.


## Exercises
There are no exercises for this course.

## Quiz
1. **True** or False: Puppet modules are self-contained bundles of code and data.

2. The Puppet init.pp manifest must include:
	a. all of the Puppet code for the module
	b. **a class with the same name as the module**
	c. a default node group 
	d. a user group resource
	
3. **True** or False: Puppet can enforce a configuration, but *cannot*  report on or remediate any drift detected.  

4. You can use the Puppet Enterprise console to add classes to which of the following ways? Select all that apply. 
	a. **the default node group**
	b. nodes outside of your Puppet deployment
	c. **individual nodes**
	d. **node groups that you define**
	e. all nodes, *except* the Puppet Master
	
5. **True** or False: You can use the runonce option to enforce a configuration across your Puppet Enterprise-managed infrastructure.

## References
* [Puppet Forge](http://forge.puppetlabs.com)
* [Puppet Labs Docs - Type Reference](http://docs.puppetlabs.com/references/latest/type.html)
* [Style Guide - Docs](http://docs.puppetlabs.com/guides/style_guide.html)
