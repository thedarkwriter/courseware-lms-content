# Introduction to the Cloud Provisioner - Course Number
**Course Overview** - A brief overview of the functionality and benefits of the cloud provisioner.

At the end of this course you will be able to:

* Describe the basic functionality of the cloud provisioner
* Describe the benefits of using the cloud provisioner
* Have a basic understanding of the workflow using the cloud provisioner
* Determine the supported cloud infrastructures

## Captivate Content
**Slide 1:** Title (with no narration)

**Slide 2:** The cloud provisioner is a command line tool built into Puppet Enterprise that allows users to quickly provision new virtual nodes when building or maintaining their cloud infrastrucutre. 

**Slide 3:** The cloud provisioner tool offers the ability to:Easily create and destroy virtual instancesClassify newly created nodes in the Puppet Enterprise consoleAnd Automatically install and configure Puppet Enterprise on newly provisioned nodes.
**Slide 4:** Here are just a few of the benefits of using the cloud provisioner:The Cloud Provisioner is flexible across multiple cloud environments, which means you can provision to any of the supported cloud computing infrastructures without having to learn an additional tool.It provides quick and effecient workflows for infrastructures that are primarily in a cloud environment.  And cloud provisioner provides a tool for provisioning and classifying new nodes with just a few commands. 
**Slide 5:** Let's take a look at a sample workflow and see how easy it is to provision to Amazon EC2:In order for the cloud provisioner to manage your infrastructure, first we need to configure a .fog file. We'll get into the details in a later lesson, but for now you can think of configuring the .fog file as a way of authenticating with your infrastructure.Once we have authentication configured, we begin by issuing a command using the cloud provisioner tool and the bootstrap action.The bootstrap action allows us to create a new node from an existing amazon image, specify the type of instance and region we want, classify the node however we want (in this example the node will be a DB server), and finally install Puppet  on the node so we can manage it from our puppet master going forward.**Slide 6:** Using Puppet Enterprise and the cloud provisioner, users are able to provision new nodes in cloud computing infrastructures based on Google Computing Engine, Amazon EC2, or VMware vSphere, without having to learn additional tools.
**Slide 7:** Summary
As we have seen, the cloud provisioner makes provisioning and classifying nodes easy and allows you to quickly scale your cloud infrastructure.**Slide 8:**
Thank you slide

## Video
[Link to Video](http://linktovideo)

## Exercises
No Exercises

## Quiz
1. True or False. The Cloud Provisioner is a suite of command-line tools that you can use to provision, classify, and scale virtual nodes. (True)
2. Which of the following tasks can you complete with the CLoud Provisioner?  a. PXE boot a node b. Automatically install Puppet Enterprise. c. Initiate a puppet run via containers. d. Change your dyno size in heroku. (b)
3. True or False. You can access the Cloud Provisioner via a web portal. (False)
4. The CLoud Provisioner supports which one of the following cloud platforms? a. Digital Ocean b. Heroku c. Openstack d. Google Compute Engine (d)
5. True or False. Before you use the Cloud Provisioner, first you need to configure authentication. (True)

## Resources
[Puppet Labs Docs](http://docs.puppetlabs.com/pe/latest/cloudprovisioner_overview.html)  
[Cloud Provisioner - Forge](https://forge.puppetlabs.com/puppetlabs/cloud_provisioner)
