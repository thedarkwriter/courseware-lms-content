# How to Deploy Code and Run the Puppet Agent  


__Why does a user need to know about this topic in order to understand configuration management with PE?__

___

Puppet Enterprise (PE) enables users to define their infrastructure's
configuration as code. Users will need to know how to work on the code that
manages their configuration. This includes an understanding of the directories
that PE looks in, to find code when compiling system definitions (the catalog),
as also an understanding of how and where to edit the code when needed.

To make things simpler for the users, PE prescribes a standard workflow centered
around Code Manager. Code Manager is a PE-only feature that is based on the open
source tool r10k. 

A new user needs to understand how Code Manager works, how to maintain and track
revisions to the code using a Version Control System (VCS), how the code from
the repository appears in the correct directories on the master etc, in order to
be able to work with PE to manage ssytem configuration. 

Perhaps a better way to define why a user needs to know about this topic is to
list issues that would happen if the user did *not* know about it. Here are a
few issues along those lines. 

Without a working knowledge of how to deploy code, a new user may be confused
about, or have the following questions at various points:  

1. Where to edit the code to make a change to system configurations - directly
   on the master? On the agent that needs a change to it's configuration?  
2. Should I backup the existing files and directories before I make a change,
   in case something goes not according to plan or design?
3. How I recover from a bad change? Where (or how) does Puppet save previous
   versions of configuration definitions, if at all it does so?
4. How do I make sure that the same change in code is enforced at the same time
   across all machines belonging to a set that needs a change made, so I don't
   have machines that all need to be configured identically be configured in
   different ways due to when or where they retrieved their configurations from?
5. If I use multiple masters, how I ensure that the code used to configure
   machines is identical on them? How would I go about making a change and
   propagating that change in code to all the masters?
6. Can I use my laptop or workstation to make edits to the code?
7. Do I have to be online and logged-in to my Puppet infrastructure to make
   edits to the Puppet code?
8. After I change the code to configure my infrastructure, how do I ensure that
   the configuration of all systems under management is changed expediently?

___
  
__What does a user need to know before they begin this module in order to succeed?__
___

The pre-requisites to this module are:

1. A working knowledge of:  
  * navigating file directories and structures on a *nix command line
  * git and version control systems
  * webhooks (optional)
  * how to add and update settings in the PE console.
  * Puppet's agent-server architecture
  * How a Puppet agent works, and how a Puppet agent run works.

2. Basic knowledge of the following Puppet concepts:
  * Puppet module structure
  * Language syntax

Preferably, users will be familiar with the following concepts in Git:
  * forking
  * branching
  * commiting code
___

__What should a user be able to do after completing this module?__
___
At a high level, a user should be able to:

1. Edit a Puppet manifest in a module that lives in a control repository
2. Manually trigger a deployment of the edited code to a Puppet server
3. Trigger a Puppet agent run on one or more agents that will be affected by the
   edited Puppet manifest.

At a more detailed level, a user should be able to:

1. Navigate the structure of a control repo to find the correct file to edit to
   make a desired change.
2. Edit a file under version control and commit the change.
3. Edit the settings in the PE console to connect the PE Puppet server to the
   control repository.
4. Log in to the Puppet Server machine, and run a command to trigger a code
   deployment.
5. Log in to the PE Console and trigger a puppet agent run on one or more
   node that have the Puppet agent installed on them.

___

__How can we assess the user's comprehension?__
___

Assuming that it may be too complicated to set up a control repository and a
puppet server for students to get hands-on practice we can assess comprehension
through a quiz with questions that guage understanding of the concepts and
techniques discussed in this lesson.

Ideally, questions in the quiz that pertain to the PE user interface would focus
on the concepts instead of any particulars about how the current version of the
PE UI is designed. For example, questions that ask the students to recall the
name of the tab or page where one can trigger a Puppet agent run should be
avoided. Instead, true/false question such as  - "The PE Console can be used to trigger
a code deployment", and "The PE console can be used to trigger Puppet agent runs
without writing a query in the prescribed format" should be used.


__What is in/out of scope for learning this topic?__
___

In scope:

* Why using version control is a good idea.
* Basic git commands to checkout, edit, and commit files, shown as an example.
* The basic structure of a control repository.
* The concept of configuring PE to talk to a control repo in git.
* The concept of a webhook to auto-deploy code on updates.
* An overview of where user-defined Puppet code and manifests live on the PE
  Puppet Server
* An understanding of Puppet Environments, and how they map to Branches in the
  control repo.

Out of scope:

* The details of how to use Git.
* Step-by-step instructions on how to connect PE to a control repo (should be
  referred to docs instead).
* Details about how to manage (what names to use for example) the use of Puppet
  Environments, since it is expected to vary widely between usecases and user
  deployments.

____

#### Objective 1: <!Write objective here>



__What sub-topics must be covered to achieve the objective?__



	Sub-Topic 1:
	*  Why do they need to know this?
	*  What are the key points of this topic?
	*  Do you have ideas for how to communicate this idea?


	Sub-Topic 2:
	*  Why do they need to know this?
	*  What are the key points of this topic?
	*  Do you have ideas for how to communicate this idea?

#### Objective 2: <!Write objective here>
__What sub-topics must be covered to achieve the objective?__


	Sub-Topic 1:
	*  Why do they need to know this?
	*  What are the key points of this topic?
	*  Do you have ideas for how to communicate this idea?

	Sub-Topic 2:
	*  Why do they need to know this?
	*  What are the key points of this topic?
	*  Do you have ideas for how to communicate this idea?
