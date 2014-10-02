# Puppet DNS

###Slide 1
In this course, you will see how to get started managing a simple DNS nameserver file with Puppet Enterprise.


###Slide 2
We'll look at:

*sample resolver class code and resolver template code.
*a sample module that contains a class called resolver to manage a nameserver file called, /etc/resolv.conf.
*an example of using the Puppet Enterprise console to add the resolver class to your agent nodes.
*how Puppet Enteprise enforces the desired state you specified in the Puppet Enterprise console.


###Slide 3
A nameserver ensures that the “human-readable” names we type in our browsers, such as google.com, can be resolved to IP addresses that our computers can read.

System administrators typically need to manage a nameserver file for internal resources that aren’t published on public nameservers. For example, let’s say you have several public-facing servers in your infrastructure, and the DNS network assigned to those servers uses Google’s public nameserver.


###Slide 4
However, there are several resources behind your company’s firewall that your employees need to access on a regular basis. In this case, you’d build a private nameserver, and then use Puppet Enterprise to ensure all the servers in your infrastructure have access to that nameserver.


###Slide 5
Before we get deep into the DNS module, let's take care of some housekeeping.

Make sure that you have Puppet Enterprise and NTP installed. You can follow the instructions in the NTP Quick Start Guide to allow Puppet Enterprise to ensure time is synchronized across your deployment. You can find a link to the NTP Quick Start Guide in the resources section of this course.


###Slide 6
It's also important to know that, by default, the modules you use to manage nodes are located in /etc/puppetlabs/puppet/modules. This includes modules installed by Puppet Enterprise, those that you download from the Forge, and those you write yourself.

Puppet Enterprise also installs modules in /opt/puppet/share/puppet/modules. It's important that you don't modify anything in this directory or add modules of your own to it.

There are plenty of resources about modules and the creation of modules that you can reference. Two good resources are Modules and Manifests, the Beginner’s Guide to Modules, and the Puppet Forge.



###Slide 7
Modules are directory trees. The resolver module looks like this:

This is your resolver init.pp, which contains the resolver class. The resolver class ensures the creation of the file /etc/resolv.conf. 


###Slide 8
The content of /etc/resolv.conf is then modified and managed by the template, resolv.conf.erb. 

The code for your resolver template looks like this:

Note that other values can be added to the template as needed.


###Slide 9
Once resolv.conf has been created, you need to add the resolver class to at least one agent node.

The simple way to do this is to search for the resolver class by name, then select the resolver class from the list of classes and add it to the console.

Now that the resolver class is added to the console, you can use the Console to add the resolver class to a node or group.   


###Slide 10
To add resolver to the node, switch the Console to the node view. Select the node, then search for resolver in the list of classes. 

Select resolver from the list and click "Update".

Your node now contains the resolver class.


###Slide 11
You've seen how to create a module from the command line, and you also can add class parameter values directly to that code using the same command line tools.  

However, there's an easier and more efficient way to add those parameters to your classes, and that's by using the Puppet Enterprise console.

After you've updated the class parameters, you can enforce those changes to your nodes. To do this, open the Live Management tab, click run once, and you're finished. 



###Slide 12
If you have a problem applying this class, the Event Inspector will tell you exactly which line of code you need to fix. If this of a successful installation, event inspector will simply confirm that Puppet Enterprise is now managing DNS.

To run a report which contains information about the puppet run that made the change, including logs and metrics about the run, click the link in the upper right corner of the detailne. 

For more information about using the Puppet Enterprise console event inspector, check out the event inspector docs. 


###Slide 13
Now imagine a scenario where a member of your team changes the contents of /etc/resolv.conf to use a different nameserver, and then they can no longer access any internal resources.

The simple solution to this is to open the Control Puppet tab and click the runonce action. This will bring the node back to the desired state.


###Slide 14
In this course, we have shown you the key concepts to install and maintain the DNS module



###Slide 15
To take a short quiz, to check your knowledge, and for more information about how to use a text editor,  click the links at the bottom of this course's page.

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