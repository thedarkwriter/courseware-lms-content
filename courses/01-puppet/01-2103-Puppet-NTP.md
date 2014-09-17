# Puppet NTP

###Slide 1
Your entire datacenter, from the network to the applications, depends on consistent time for many different functions, such as security services, certificate validation, and file sharing across nodes.


###Slide 2
In this lesson, we give you an overview of how to use Puppet Enterprise to:

*to install the NTP module 
*add classes from the NTP module to your agent 
*view changes made by the main NTP class
*edit parameters of the main NTP class


###Slide 3
The Puppet Labs NTP module is a Puppet-supported module. These modules are supported, tested, and maintained by Puppet Labs. 

Because the NTP module is on the Puppet Forge, you can easily install it with a simple command from the Puppet Enterprise Master.


###Slide 4
Before digging into how to install the NTP module, it might be valuable to see the Puppet code itself.

###Slide 5
Puppet code is written in short strings of human-readable language. This is a snippet of puppet code that defines the NTP class and its resources. You can see here that very little code is required to perform this critical task of configuring and deploying NTP. 

In this particular code snippet, the keys are defined as follows:

Servers selects the servers to use for ntp peers
Restrict sets which servers are able to connect to the NTP server
UDLC allows the node to use its own local time if a connection cannot be established with the NTP server
Service_manage selects whether Puppet should manage the service
Config_template determines which template Puppet should use for the ntp configuration.


###Slide 6
Now that you've seen what you'll be installing, let's look at the installation process.

###Slide 7
The NTP module contains several classes. Classes are named chunks of puppet code and are the primary means by which Puppet Enterprise configures nodes. The NTP module classes include:
 
* `ntp`: This is the main class. It includes all other classes, including:
* `ntp::install`: This class handles the installation packages.
* `ntp::config`: This class handles the configuration file.
* `ntp::service`: This class handles the service.

To install the NTP classes, you only need to add the main class to the Puppet Master. As with the NTP module, the installation process is automated. 


###Slide 8
The Puppet Enterprise console event inspector lets you view and research changes and other events. For example, after applying the `ntp` class, you can use event inspector to confirm that changes (or "events") were indeed made to your infrastructure. 

In this image, you can see that one event, a successful change, has been recorded for Nodes: with events. 




###Slide 9
There are also two changes for "Classes: with events" and "Resources: with events". This is because the ntp class loaded from the puppetlabs-ntp module contains additional classes. A class that handles the configuration of NTP, and a class that handles the NTP service.

You can confirm that these classes were successfully added by adding the main NTP class and making a Puppet run. To verify their addition,  click "With Changes" in the "Classes: with events" section. 

These changes can be viewed in the Summary pane.


###Slide 10
You can drill down all the way to the exact line of puppet code responsible for generating the event, as is called out here by the highlight box. 

If you have a problem applying this class, the Event Inspector will tell you exactly which line of code you need to fix. If you have a problem applying this class, the Event Inspector will tell you exactly which line of code you need to fix. If this of a successful installation, event inspector will simply confirm that Puppet Enterprise is now managing NTP.

To run a report which contains information about the puppet run that made the change, including logs and metrics about the run, click the link in the upper right corner of the detail pain. 

For more information about using the Puppet Enterprise console event inspector, check out the event inspector docs. 


###Slide 11
You can edit or add class parameters in the PE console, largely eliminating the need to edit code directly in the module. 

The NTP module, by default, uses public NTP servers. But what if your infrastructure runs an internal pool of NTP servers? 

You can use the Puppet Enterprise console to change the server parameter of the `ntp` class in only a few steps. The servers field is highly visible and easility editable.

Remember to use the event inspector to be sure the changes were correctly applied to your nodes!


###Slide 12
In this lesson, we have shown you the key concepts to install and maintain the NTP module

We hope that this brief introduction to NTP has shown you how easy it is to implement and verify NTP using Puppet.


###Slide 13
To check your knowledge and for more additional related resources,  click the links at the bottom of this course's page.





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
4. True or False. The git get command will pull a copy of the master repository to your local workstation. **False**
5. True or False. Puppet code is human-readable. **True**

## References ##
* [Puppet NTP Module](https://forge.puppetlabs.com/puppetlabs/ntp)
* [NTP Installation Quick-Start](https://docs.puppetlabs.com/pe/latest/quick_start_ntp(.html)
* [Event Inspector Docs](https://docs.puppetlabs.com/pe/latest/console_event-inspector.html)

##Bogus note