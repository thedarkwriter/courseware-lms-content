Now that you have learned some basics about resources and how they help you do simple tasks, let's look at how using Puppet syntax works for more complex tasks.

Imagine you are a new system administrator, hired to help deploy Puppet to eventually configure the fleet of servers in your corporate infrastructure. That's a big task! Your manager has come to you with the following request as a starting point. Your first job is to understand Puppet&rsquo;s syntax enough to be able to work on this project and get it done.&nbsp;

> "We need to deploy our new internally developed corporate directory intranet application named **Robby**. Robby consists of several pieces including backend database servers and frontend web servers. It serves the worldwide corporate offices and allows employees to publish information about themselves for other employees to see, such as a profile picture, a short bio, notable career achievements and what they like to do for fun. Use Puppet to deploy Robby to our corporate datacenter according to the currently documented manual runbook."

**NOTE:** A *runbook* is a compilation of routine procedures and operations that the system administrator or operator carries out.

With that request, it's time to start figuring out how to achieve it using Puppet. Looking at the runbook, you discover that the following servers, all running the latest version of RedHat Enterprise Linux, must be configured:

* **db1.mycorp.com** - primary database server
* **db2.mycorp.com** - secondary database server (failover machine)
* **web1.mycorp.com** - web/application server

Before Puppet, it was necessary to log into these 3 servers and manually execute commands in order according to the runbook. Now with Puppet, you write code to apply changes automatically on each server, based on the final configuration required by each one to make a fully-functioning deployment of the Robby application.

With Puppet, you'll start with a **resource**. As you learned earlier, a resource is Puppet's representation of a characteristic of a server that should be managed or configured, such as a file, a user account, a software package installation and many other possibilities.

**Core resource types** are the most essential resource types you will use to interact with Puppet and tell it what to do. They are ready to go when you install Puppet, meaning you don&rsquo;t have to do anything extra to set them up.

One example of a core resource type you have gotten some practice working with previously in this course is the `file` type. The full list of all core resource types is posted on our [type reference page](https://puppet.com/docs/puppet/latest/type.html), and the package type reference can found [here](https://puppet.com/docs/puppet/latest/types/package.html).

The `package` type manages software packages. Often, this type is seen with a simple `ensure` attribute to install a package. Other useful attributes of this type include `source` and `provider`. For example:

<pre>
package { 'openssh-server':
  ensure => installed,
}
</pre>

<pre>
package { 'ruby-dbus':
  ensure   => '0.13.0',
  provider => 'gem',
}
</pre>

## Task:
Enter the `puppet resource` command to see which attribute is assigned to the `package` named `puppet`.

<p><iframe src="https://magicbox.classroom.puppet.com/resources/exploring_package" width="100%" height="500px" frameborder="0"></iframe></p>

## Task:
The first thing needed for Robby to operate is to install all of the required software packages on the various servers shown previously. The runbook starts with the following package installation instructions:

* Install the PostgreSQL database (package name: `postgresql-server`) on db1.mycorp.com and db2.mycorp.com
* Install the Apache web server (package name: `httpd`) on web1.mycorp.com
* Install the Robby application (package name: `robby`) on web1.mycorp.com

Install the required packages on the database servers and the web server. The first task gives you help with the syntax, but the remaining tasks require you to enter the syntax on your own. Refer to the correct syntax in the first task box below if you get stuck.

**db1.mycorp.com** (PostgreSQL database server):

<iframe src="https://magicbox.classroom.puppet.com/scenario/install_database_package" width="100%" height="500px" frameborder="0"></iframe>

**web1.mycorp.com** (Apache web server):

<iframe src="https://magicbox.classroom.puppet.com/scenario/install_httpd_package" width="100%" height="500px" frameborder="0"></iframe>

**web1.mycorp.com** (Robby application):

<iframe src="https://magicbox.classroom.puppet.com/scenario/install_robby_package" width="100%" height="500px" frameborder="0"></iframe>
