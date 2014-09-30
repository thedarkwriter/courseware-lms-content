# Puppet Firewall

###Slide 1
In this course, you will see how to get started managing firewall rules with Puppet Enterprise.


###Slide 2
In it, you will see an overview of how to:

*write a simple firewall module
*use the PE console to add the my_firewall class to your agent nodes.
*write a class to open ports for the Puppet master.
*enforce the desired state of the my_firewall class.


###Slide 3
System administrators define a set of firewall policies that usually manage functions such as application ports, node interfaces, IP addresses and an accept/deny statement. These rules are applied in a “top-to-bottom” approach. For example, if a node that has access to a port, and part of t group that does not have access to that port, the node will inherit the group restriction. 

Another example is When a service such as SSH attempts to access resources on the other side of a firewall, the firewall applies a list of rules to determine if or how SSH communications are handled. If a rule allowing SSH access can’t be found, the firewall will deny access to that SSH attempt.


###Slide 4
If you haven’t already done so, you’ll need to install Puppet Enterprise and NTP. See the system requirements for supported platforms.

Puppet NTP insures that your nodes are synchronous. You can find a link to the NTP Quick Start Guide in the resources section of this lesson.


###Slide 5
The first thing to know is that, by default, the modules you use to manage nodes are located in /etc/puppetlabs/puppet/modules—this includes modules installed by Puppet Enterprise, those that you download from the Forge, and those you write yourself.

Puppet Enterprise also installs modules in /opt/puppet/share/puppet/modules. It's important that you don't modify anything in this directory or add modules of your own to it.

There are plenty of resources about modules and the creation of modules that you can reference. Check out Modules and Manifests, the Beginner’s Guide to Modules, and the Puppet Forge.


###Slide 6
Modules are directory trees. The example module used in this course is called my_firewall, and it looks like this:


###Slide 7
The pre.pp manifest looks like this:

The key resources in this module are:
proto
iniface
action
state
port


###Slide 8
The post.pp manifest looks like this:


###Slide 9
The init.pp manifest looks like this:

You can see that it contains the pre and post manifests.

###Slide 10
Modules are directory trees. The my_firewall module looks like this:


###Slide 11
The Puppet master is just like any other application you run from your infrastructure: you need to open ports to ensure you can access the Puppet master correctly.

To do this, you will create another module. We'll call this module "my_master".


###Slide 12
The init.pp that you create for the my_master module looks like this:


###Slide 13
Best practice is to create a new group for each set of firewall rules, then to each group add the nodes that should be goverened by the firewall rules. Finally, add your firewall rule class to the group that you created.

Now imagine a scenario where a member of your team changes the contents of the iptables to allow connections on a random port that was not specified in my_firewall.

However, my_firewall is already defined and applied to a group. All that's required is to let the scheduled Puppet run to begin. Otherwise, go to the Management tab, run once, and you’re finished. 


###Slide 14
In this course, we have shown you the key concepts to install and maintain the Firewall module

We hope that this brief introduction to Firewalls has shown you how easy it is to implement and verify DNS using Puppet.


###Slide 15
To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.


## Video ##

## Exercises ##
There are no exercises for this course.

## Quiz ##

1. True or False. The directory in which you should edit your modules is /opt/puppet/share/puppet/modules **False**

2. The name of the Puppet DNS template file is:
	a. DNS.conf.pp
	b. DNS.template.erb
	c. **resolve.conf.erb**
	d. resolve.template.pp
3. Which of the following are classes within the DNS module?
	a. DNS
	b. DNS::Config
	c. **Resolver
	d. Resolve
4. True or False. Resolver parameters should always be set in the resolver.conf file. **False**
5. True or False. The local node copy of the nameserver file is the basis for desired state enforcement. **False**

## References ##
* [Modules and Manifests](Modules and Manifests)
* [Beginner’s Guide to Modules](https://docs.puppetlabs.com/pe/latest/guides/module_guides/bgtm.html)
* [The Puppet Forge](https://forge.puppetlabs.com/)
* [Event inspector docs](https://docs.puppetlabs.com/pe/latest/console_event_inspector)