Now that you have learned some basics about resources and how they help you do simple tasks, let's look at how using Puppet syntax works for more complex tasks.

Imagine you are a new system administrator, hired to help deploy Puppet to eventually configure the fleet of servers in your corporate infrastructure. That's a big task! Your manager has come to you with the following request as a starting point. Your first job is to understand Puppet&rsquo;s syntax enough to be able to work on this project and get it done.&nbsp;

> "We need to deploy our new internally-developed corporate directory intranet application named <strong>Robby</strong>. Robby consists of several pieces including backend database servers, frontend web servers and a load balancer. It serves the worldwide corporate offices and allows employees to publish information about themselves for other employees to see, such as a profile picture, a short bio, notable career achievements and what they like to do for fun. Use Puppet to deploy Robby to our corporate datacenter according to the currently documented manual runbook."

With that request, it's time to start figuring out how to achieve it using Puppet. Looking at the runbook, you discover that the following servers, all running the latest version of RedHat Enterprise Linux, must be configured:

* **db1** - primary database server
* **db2** - secondary database server (failover machine)
* **web1** - web/application server

Before Puppet, it was necessary to log into these 3 servers and manually execute commands according to the runbook. Now with Puppet, you have to write some code to apply changes automatically on each server, based on the final configuration required by each one to make a fully-functioning deployment of the Robby application.

With Puppet,&nbsp;you'll start with&nbsp;a **resource**. As you learned earlier, a</span>&nbsp;resource is Puppet's representation of a characteristic of a server that should be managed or configured, such as a file, a user account, a software package installation and many other possibilities.

The first thing needed for Robby to operate is to install all of the required software packages on the various servers shown previously. The runbook starts with the following package installation instructions:

* Install the PostgreSQL database (current released version) on db1 and db2 using the standard RHEL yum repositories
* Install the Apache web server (current released version) on web1 using the standard RHEL yum repositories

**Core resource types** are the most essential resource types you will use to interact with Puppet and tell it what to do. They are ready to go when you install Puppet, meaning you don&rsquo;t have to do anything extra to set them up.

One example of a core resource type you have gotten some practice working with previously in this course is the `file` type. The full list of all core resource types is posted on our [type reference page](https://puppet.com/docs/puppet/5.3/type.html)

The `package` type manages software packages. Some important attributes of this type include `name`, `ensure`, `source`, and `provider`. For example:

<pre>
package { 'openssh-server':
  ensure => installed,
}
</pre>

## Task:
Enter the `puppet resource` command to see which attribute is assigned to the `package` named `puppet`.

<p><iframe src="https://magicbox.classroom.puppet.com/resources/exploring_package" width="100%" height="500px" frameborder="0"></iframe></p>
