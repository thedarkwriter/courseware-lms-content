# An Introduction to the Console
The Puppet Enterprise Console is a web-based graphical user interface for your infrastructure. This course is a high level overview of the Console covering the main functional areas.

At the end of this course you will be able to: 

* Describe the general layout and functional areas of the PE console.

## Video

## Slide 0



## Slide 1

The Puppet Enterprise Console is a web-based graphical user interface for your infrastructure.

## Slide 2

With the console you can:

* manage node requests to join the Puppet deployment.
* assign Puppet classes to nodes and groups.
* view reports and activity graphs.
* trigger Puppet runs on demand.
* browse and compare resources on your nodes.
* view inventory data.
* invoke orchestration actions on your nodes.
* manage console users and their access privileges.

## Slide 3

Navigate between sections of the console using the main navigation at the top.

The following navigation items all lead to their respective sections of the console:
The nodes, groups, classes, and reports sections of the console are closely intertwined, and contain tools for inspecting the status of your systems and assigning configurations to them.

## Slide 4


A list will show the name of each node that is relevant to the current view (members of a group, for example), a graph of their recent aggregate activity, and a few details about each node’s most recent run. Node names will have icons next to them representing their most recent state.
Every node list includes an “Export nodes as CSV” link, for use when importing data into a spreadsheet.

Clicking the name of a node will take you to that node’s node detail page, where you can see in-depth information and assign configurations directly to the node. 

## Slide 5

Groups let you assign classes and variables to many nodes at once. This saves you time and makes the structure of your site more visible.
Nodes can belong to many groups, and will inherit classes and variables from all of them. Groups can also be members of other groups, and will inherit configuration information from their parent group the same way nodes do.

Special Groups
Puppet Enterprise automatically creates and maintains several special groups in the console:
The Default Group
The console automatically adds every node to a group called default. You can use this group for any classes you need assigned to every single node.
Nodes are added to the default group by a periodic background task, so it may take a few minutes after a node first checks in before it joins the group.
The MCollective and No MCollective Groups
These groups are used to manage Puppet Enterprise’s orchestration engine.
  ◦ The no mcollective group is manually managed by the admin user. You can add any node that should not have orchestration features enabled to this group. This is generally used for non-PE nodes like network devices, which cannot support orchestration.
  ◦ The mcollective group is automatically managed by a periodic background task; it contains every node that is not a member of the no mcollective group. Admin users can add classes to this group if they have any third-party classes that should be assigned to every node that has orchestration enabled. However, you should not remove the pe_mcollective class from this group.
The Master, Console, and PuppetDB Groups
These groups are created when initially setting up a Puppet Enterprise deployment, but are not automatically added to.
  ◦ puppet_master — this group contains the original puppet master node.
  ◦ puppet_console — this group contains the original console node.
  ◦ puppet_puppetdb — this group contains the original database support node.

## Slide 6

Classes are the main unit of Puppet configurations. The classes the console knows about are a subset of the classes available to the puppet master. You must explicitly add classes to the console before you can assign them to any nodes or groups. If you click the name of a class to see its class detail page, you can view a node list of every node assigned that class. Class detail pages contain a description of the class, a recent run summary, and a list of all nodes to which the class is assigned. The node list includes a “source” column, which shows, for each node, whether the class was assigned directly or via a group. (When assigned via a group, the group name is a link to the group detail page.)

## Slide 7

Each report represents a single Puppet run. Clicking a report will take you to a tabbed view that splits the report up into metrics, log, and events.
Metrics is a rough summary of what happened during the run, with resource totals and the time spent retrieving the configuration and acting on each resource type.
Log is a table of all the messages logged during the run.
Events is a list of the resources the run managed, sorted by whether any changes were made. You can click on a changed resource to see which attributes were modified.

## Slide 8

This section contains all of the fact values reported by the node on its most recent run.

## Slide 9

The Puppet Enterprise (PE) console’s live management page is an interface to PE’s orchestration engine. It can be used to browse resources on your nodes and invoke orchestration actions.
  ◦ The Browse Resources tab lets you browse, search, inspect, and compare resources on any subset of your nodes.
  ◦ The Control Puppet tab lets you invoke Puppet-related actions on your nodes. These include telling any node to immediately fetch and apply its configuration, temporarily disabling puppet agent on some nodes, and more.
  ◦ The Advanced Tasks tab lets you invoke orchestration actions on your nodes. It can invoke both the built-in actions and any custom actions you’ve installed.

## Slide 10

Puppet Enterprise (PE) event inspector is a reporting tool that provides data for investigating the current state of your infrastructure. Its focus is on correlating information and presenting it from multiple perspectives, in order to reveal common causes behind related events. Event inspector provides insight into how Puppet is managing configurations, and what is happening where when events occur.
Event inspector lets you accomplish two important tasks: monitoring a summary of your infrastructure’s activity and analyzing the details of important changes and failures. Event inspector lets you analyze events from several different perspectives, so you can reject noise and choose the context that best allows you to understand events that concern you.

There are four kinds of events, all of which are shown in event inspector:
  ◦ Change: a property was out of sync, and Puppet had to make changes to reach the desired state.
  ◦ Failure: a property was out of sync; Puppet tried to make changes, but was unsuccessful.
  ◦ Noop: a property was out of sync, but Puppet was previously instructed to not make changes on this resource (via either the --noop command-line option, the noop setting, or the noop => true metaparameter). Instead of making changes, Puppet will log a noop event and report the changes it would have made.
  ◦ Skip: a prerequisite for this resource was not met, so Puppet did not compare its current state to the desired state. (This prerequisite is either a failure in one of the resource’s dependencies or a timing limitation set with the schedule metaparameter.) The resource may be in sync or out of sync; Puppet doesn’t know yet.

## Slide 11

The sidebar contains the following elements:
  ◦ The background tasks indicator. The console handles Puppet run reports asynchronously using several background worker processes. This element lets you monitor the health of those workers. The number of tasks increases as new reports come in, and decreases as the workers finish processing them. If the number of tasks increases rapidly and won’t go down, something is wrong with the worker processes and you may need to use the advanced tasks tab to restart the pe-puppet-dashboard-workers service on the console node. A green check-mark with the text “All systems go” means the worker processes have caught up with all available reports.
  ◦ The node state summary. Depending on how its last Puppet run went, every node is in one of six states. A description of those states is available here. The state summary shows how many nodes are in each state, and you can click any of the states for a view of all nodes in that state. You can also click the “Radiator view” link for a high-visibility dashboard (see below for a screenshot) and the “Add node” button to add a node before it has submitted any reports. (Nodes are automatically added to the console after they have submitted their first report, so this button is only useful in certain circumstances.)
  ◦ The group summary, which lists the node groups in use and shows how many nodes are members of each. You can click each group name to view and edit that group’s detail page. You can also use the “Add group” button to create a new group.
  ◦ The class summary, which lists the classes in use and shows how many nodes have been directly assigned each class. (The summary doesn’t count nodes that receive a class due to their group membership.) You can click each class name to view and edit that class’s detail page. You can also use the “Add classes” button to add a new class to the console.

## Slide 12

Node Requests
Whenever you install Puppet Enterprise on a new node, it will ask to be added to the deployment. You must use the request manager to approve the new node before you can begin managing its configuration.

The navigation item containing your username (“admin,” in the screenshot above) is a menu which provides access to your account information and (for admin users) the user management tools.
The licenses menu shows you the number of nodes that are currently active and the number of nodes still available on your current license. 
Working with Licenses
The licenses menu shows you the number of nodes that are currently active and the number of nodes still available on your current license. If the number of available licenses is exceeded, a warning will be displayed. The number of licenses used is determined by the number of active nodes known to Puppetdb. This is a change from previous behavior which used the number of unrevoked certs known by the CA to determine used licenses. The menu item provides convenient links to purchase and pricing information.
Unused nodes will be deactivated automatically after seven days with no activity (no new facts, catalog or reports), or you can use puppet node deactivate for immediate results. The console will cache license information for some time, so if you have made changes to your license file (e.g. adding or renewing licenses), the changes may not show for up to 24 hours. You can restart the pe-memcached service in order to update the license display sooner.


User Access and Privleges & Administration

The help menu leads to the Puppet Enterprise documentation.


## Slide 13





## Exercises
There are no exercises for this course. However, you can download Puppet Enterprise for free and use it on up to 10 nodes to test the features of the Console. [Download PE](https://puppetlabs.com/puppet/puppet-enterprise)

## Quiz
1. True or **False**. The Console is a command line tool that can help set up your PE installation.
2. Which section (or page) displays a daily run status?
	a. Groups
	b. Live Management
	c. **Nodes**
	d. Classes
3. Which of the following is **not** a tab available in Reports?
	a. Metrics
	b. Log
	c. Events
	d. **Failures**
4. Which section (or page) is an interface to the Orchestration Engine (i.e. MCollective)?
	a. **Live Management**
	b. Event Inspector
	c. Classes
	d. Groups
5. **True** or False. The Event Inspector will show you the current state of your infrastructure.


## References
* [Accessing the Console - Docs](http://docs.puppetlabs.com/pe/latest/console_accessing.html)
* [Navigating the Console - Docs](http://docs.puppetlabs.com/pe/latest/console_navigating.html)
* [Download PE](https://puppetlabs.com/puppet/puppet-enterprise)
