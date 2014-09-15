# Puppet DNS

###Slide 1
In this course, you will see how to get started managing a simple DNS nameserver file with PE


###Slide 2
In this lesson, you will see:

*sample resolver class code and resolver template code.
*how to write a simple resolver module
*how to use the PE console to add the resolver class to your agent nodes.
*How to enforce the desired state


###Slide 3
A nameserver ensures that the “human-readable” names we type in our browsers (e.g., google.com) can be resolved to IP addresses our computers can read.

Sysadmins typically need to manage a nameserver file for internal resources that aren’t published in public nameservers. For example, let’s say you have several publicly-facing servers in your infrastructure, and the DNS network assigned to those servers use Google’s public nameserver.


###Slide 4
However, there are several resources behind your company’s firewall that your employees need to access on a regular basis. In this case, you build a private nameserver, and then use Puppet Enterprise to ensure all the servers in your infrastructure have access to the nameserver.


###Slide 5
If you haven’t already done so, you’ll need to get PE installed. See the system requirements for supported platforms.

Follow the instructions in the NTP Quick Start Guide to have PE ensure time is in sync across your deployment. You can find a link to the Quick Start Guide in the resources section of this lesson.


###Slide 6
This module will be a very simple module to write. It contains just one class and one template.

###Slide 7
The first thing to know is that the modules you use to manage nodes are located in /etc/puppetlabs/puppet/modules. This includes modules installed by PE, those that you download from the Forge, and those you write yourself.

Note: PE also installs modules in /opt/puppet/share/puppet/modules, but don’t modify anything in this directory or add modules of your own to it.

There are plenty of resources about modules and the creation of modules that you can reference. Check out Modules and Manifests, the Beginner’s Guide to Modules, and the Puppet Forge. You will find links in the References section below



###Slide 8
Modules are directory trees. The resolver module looks like this:


###Slide 9
The resolver class in your resolver manifest will look like this:

Note that other values can be added to the template as needed.

The class resolver ensures the creation of the file /etc/resolv.conf.

The content of /etc/resolv.conf is modified and managed by the template, resolv.conf.erb. You will set this content in the next task using the PE console.




###Slide 10
Once resolve.conf is in place, the first thing you need to do is add the resolver class to at least one agent node.

The manual way to do this is to add the resolver class to your agents individually.

The automated way to do this is to add resolver to the default node group, or create a new node group for this class.

Both of these methods require that the resolver class be added to the console, which can be done from the Add Classes panel. This is as simple as searching for the class by name, selecting the resolver class, and clicking “add classes”.


###Slide 11
While the resolver class will now appear in your node’s list of classes, it has not yet been fully configured. You still need to add the nameserver IP address parameter for the resolver class to use. You can do this by adding a parameter right in the console.


###Slide 12
You can add class parameter values to the code in your module, but it’s easier to add those parameters to your classes using the PE console.

To do this, navigate to your node. In edit mode, find the resolver list and edit its parameters. Add the IP address of the nameserver and click “done” to accept the changes.

From the Live Management tab, run once, and you’re finished. The customer nameserver now appears in your resolv.conf.



###Slide 13
The PE console event inspector lets you view and research changes. You can view changes by class, resource, or node. By viewing the details of changes to class, you will see that that the class created /etc/resolv.conf and set the contents according to the module’s template.

The further you drill down in event inspector, the more detail you’ll receive. If there had been a problem applying the resolver class, this information would tell you exactly where that problem occurred or which piece of code you need to fix.

In the upper right corner of the screen is a link to a run report, which contains information about the changes made during puppet runs, including logs and metrics about the run. 


###Slide 14
Now imagine a scenario where a member of your team changes the contents of /etc/resolv.conf to use a different nameserver and can no longer access any internal resources.

The simple solution to this is to open the Control Puppet tab and click the runonce action. This will bring the node back to the desired state.

To verify that Puppet has enforced the desired state, navigate to /etc/resolv.conf and see that the nameserver IP address is as specified in the Console. 


## Video ##

## Exercises ##
There are no exercises for this course.

## Quiz ##

1. The NTP module is written in:
	a. Markdown
	b. **Puppet Code**
	c. HTML	
	d. Python
2. Using Puppet Enterprise provides which advantages when deploying NTP:
	a. The code is simple and brief
	b. **Event inspector can be used to check status
	c. **Automation
	d. **Events can be traced to the code level
3. Which of the following are classes within the NTP module?
	a. **NTP
	b. **NTP::Install
	c. **NTP::Config
	d. NTP::Deploy
4. True or False. The NTP class can restrict access to the NTP server. **True**
5. True or False. NTP can only be administrated at the agent level. **False**

## References ##
* [Modules and Manifests](Modules and Manifests)
* [Beginner’s Guide to Modules](https://docs.puppetlabs.com/pe/latest/guides/module_guides/bgtm.html)
* [The Puppet Forge](https://forge.puppetlabs.com/)
* [Event inspector docs](https://docs.puppetlabs.com/pe/latest/console_event_inspector)