# Rspec-Puppet
*(for example: The Puppet exec Resource)*

Rspec-Puppet provides a unit-testing framework for Puppet. It extends RSpec to allow the testing framework to understand Puppet catalogs, the artifact it specializes in testing. You can write tests to test that aspects of your module work as intended.

After completing this course you will be able to:

* Learning Objective #1
* Learning Objective #n

*(for example: Apply the exec resource appropriately.)*


## Slide Content
*(This will become the content for the instructional video, which will be built in Captivate by the instructional designer. For each slide, describe the concept to be presented. If possible, include a description of the graphics you want to have represent the concept. Then provide a narrative ,the audio track to be recorded. Be as complete and specific as possible.)*

### slide 1 - Title
slide text / notes / etc. *(for example:* 

*Audio: The Puppet exec resource type allows you to execute operating system commands from within your Puppet manifests. It is a particularly useful tool when there is no built-in Puppet resource type to perform a task.)*

### slide 2 - Objectives
slide text / notes / etc. *(for example:*

*Audio: In this course, we look at how to apply the Puppet exec resource appropriately to ensure that you maintain the idempotency of your Puppet manifests.  Before completing this intermediate level course, we recommend that you complete the Puppet Labs Workshop Resources course.)*

### slide n
slide text / notes / etc. 

### slide n
slide text / notes / etc.

### slide n
slide text / notes / etc.

### slide n - Summary
*(Summarize the major points made in the course. You can simply restate the learning objectives from the second slide in the presentation. Or you can write a concluding statement. For example:*

*When used carefully and appropriately, exec resources are your secret weapon in automating your infrastructure. Exec resources can be utilised to achieve results where there is no native or module-contributed resource type.)*


### slide n - Resources and Quiz

To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.

### slide 15 - Thank you

Thank you for completing this Puppet Labs Workshop course.


## Exercises
1. Exercise question or direcrtion. Include sample code if needed.
2. Multiple exercise questions are appropriate. It is recommended that you limit the number of exercises to 3.

*(For example:*

*Assuming you have a working Puppet installation:*

*1. Execute the puppet resource command to query the users on your system. (Use the Learning VM or your own personal puppet installation.)*


## Quiz
1. T/F or Multiple Choice
2. T/F or Multiple Choice
3. T/F or Multiple Choice
4. T/F or Multiple Choice
5. T/F or Multiple Choice

###*For example:*

## Quiz
1. True or **False**: Use the exec resource type instead of Puppet code whenever possible.

2. The Puppet exec resource allows you to:
	a. Write modules that are inherently idempotent.
	b. **Access the operating system to execute commands and run scripts.**
	c. Disregard idempotency when you write Puppet modules.
	d. Avoid using scripts to execute operating system commands.
	
3. **True** or False: When you call a script from the exec resource, you need to ensure that the script operates idempotently.  

4. Any command in an exec resource must:
	a. Use the onlyif attribute to restrict run conditions.
	b. Call a script in order to run operating system commands.
	c. Include the `path` attribute.
	d. **Be able to run multiple times without causing harm.**
	
5. It is *not* a best practice to chain multiple exec resources together to accomplish a task because:
	a. Multiple exec resources can not be idempotent.
	b. Puppet only lets you use one resource to accomplish a task.
	c. **Using a collection of exec resources can be complicated and confusing.**
	d. the puppet module tool

## References
* [Docs](link)
* [Website](link)
* [*n*](link)


###*For Example:*

## References
* [Puppet Forge](http://forge.puppetlabs.com)
* [Puppet Labs Docs - Type Reference](http://docs.puppetlabs.com/references/latest/type.html)
* [Style Guide - Docs](http://docs.puppetlabs.com/guides/style_guide.html)
