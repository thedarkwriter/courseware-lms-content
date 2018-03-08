### Understand Puppet architecture and declarative structure (possible names: Puppet deployment; how puppet master and agent work; Puppet's agent/master architecture; Automating with Puppet: Architecture)
	

__Why does a user need to know about this topic in order to understand configuration management with PE?__

___
Puppet Enterprise is based around the Puppet language, a declarative programming language. The Puppet language describes **what** the final state of a server should be instead of **how** to get it into that state. Contrast that with many common programming languages (Java, C++, and others) that describe the exact steps **how** to arrive at a solution to a problem.

By giving the system administrator the power to describe the final state of a server, they are relieved of the low-level specifics about how to get the server into that state. Puppet Enterprise interprets the Puppet language code and translates it into commands to bring the server into the desired state. In many cases, these are the **same commands** that the system administrator would type manually, but they are executed automatically and with repeatability.
___
  
__What does a user need to know before they begin this module in order to succeed?__
___
Basic syadamins:

* Understand how to configure a machine and keep it running in the infrastructure, including the specific commands used to do so
* Optionally, some familiarity with scripting on Linux and/or Windows (shell or Powershell)

___

__What should a user be able to do after completing this module?__
___

After completing this module, the user should understand the concept of a declarative programming language vs. a procedural/imperative 
programming language. The user should understand that they do not have to be concerned with **how** the final state of a server is 
achieved, just **what** the final state should be. The user should also understand that at its most basic level, Puppet Enterprise 
converts Puppet language code into system commands to configure one or several thousand servers into a desired state. The user should be 
able to understand the resource abstraction layer, and make the connection between the RAL and the concept of configuring infrastructure. 
___

__How can we assess the user's comprehension?__
___

This unit can be assessed with a multiple choice quiz to test whether the user understands the concept of declarative programming languages vs. procedural/imperative languages.
Potential for self-assessment through interactive .js exercises that ask the user to show how the master/agent architecture works

**NOTE: Questions can be added to a separate doc where you write module content**
___

__What is in/out of scope for learning this topic?__
___

The concept of declarative vs. procedural/imperative programming languages is the primary focus of this unit. The user does not necessarily need previous programming experience of any kind, and this unit will not teach basic computer programming concepts. The main point to communicate is the concept of defining a server configuration end state (the **what**) vs. "the **how**" to get it into that state.
___

____

####Objective 1: Be able to describe the configuration as a state

__What sub-topics must be covered to achieve the objective?__


	Sub-Topic 1:
Declarative structure versus imperative
	
	*  Why do they need to know this?  
Entire theory of how Puppet works, how they start to shift their thinking from imperative to declarative


	*  What are the key points of this topic?
Declarative definition and how it differs from imperative.
The application and benefits of declarative structure in system config


	*  How can we communicate this?

Recipe analogy to describe difference between declarative and imperative
Configure a machine normally (shell script example to write a file, for example) and then show how you would do it with Puppet


	Sub-Topic 2:
At its most basic level, Puppet Enterprise converts Puppet language code into system commands to configure a server into its desired state.		
	
	*  What are the key points of this topic?
Puppet can be used to configure one machine and can scale to several thousand nodes.

	*  Do you have ideas for how to communicate this idea
Show difference of shell script modifying a basic file v. a single Puppet resource doing same thing
Puppet language compiler example

	

####Objective 2: Users will understand Puppet lifecycle be able to connect RAL to the concept of configuration management.

__What sub-topics must be covered to achieve the objective?__


	Sub-Topic 1:
Puppet Resource Abstraction Layer	
	*  What are the key points of this topic?
The definition of RAL and how it is used to configure infrastructure.

	*  Do you have ideas for how to communicate this idea?
Use the animation from Puppet Resources self-paced module currenlty on LearnDot

	Sub-Topic 2:
Lifecycle of a Puppet run		
	
	*  What are the key points of this topic?

How a lifecycle works: Master/agent concepts at a higher level.
Idempotency
All code lives on the Master and master contains compiler that translates code into a compiled form, similar to computer program that executes

	*  Do you have ideas for how to communicate this idea?
Provide an example outside IT: Central processor and peripheral devices receiving data, like a cable TV. Connection to a central service and receiving data based on preferences.

MEDIA: Animation 
Continue idea of shell script from above. Use the shell script example and now apply it to 1000 servers. Show every step a sysadmin would need to take to do this. Then show the sysadmin using Puppet and sending code once to master and the master does this work--not a sysadmin sitting at a keyboard. Sysadmin goes to bed while Puppet master and agent are doing their work

