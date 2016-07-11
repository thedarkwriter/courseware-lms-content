# The Exec Resource

The exec resource is a powerful tool that allows you to access operating system commands and execute scripts from within your Puppet manifests. It is especially useful when there is no available  Puppet resource type to perform a function. 

After completing this course, you will be able to apply the exec resource appropriately and ensure that you maintain the idempotency of your Puppet manifests. 

## Slide Content

### Slide 1 - Title
The Puppet exec resource type allows you to execute operating system commands from within your Puppet manifests. It is a particularly useful tool when there is no built-in Puppet resource type to perform a task.

### Slide 2 - Objectives

In this course, we look at how to apply the Puppet exec resource appropriately to ensure that you maintain the idempotency of your Puppet manifests.  Before completing this intermediate level course, we recommend that you complete the Puppet Labs Workshop Resources course. 

### Slide 3 - Idempotency

The Puppet exec resource is sort of like a pocket knife that includes a variety of tools.  You can use it to perform many tasks. And yet it is not specially designed for any one of those tasks. Because it allows you to access the operating system to execute commands and run scripts, the exec resource is very powerful. However, it can be tricky to apply due to the interdependencies of many of the attributes, and you may find that your results are not what you had anticipated. Before using the exec resource, you may want to check out the Puppet Forge where there are many tried and tested modules, one of which may accomplish your task. 


### Slide 4
Now, before we look at the exec resource in detail -  let's do a brief review of idempotency and Puppet.  By design, Puppet resource types and providers are idempotent. They describe a desired final state rather than a series of steps to follow. So, a resource can be applied multiple times with the same outcome.  By default, every 30 minutes the Puppet Agent wakes up and makes sure that the node is configured properly. If the node is in the desired state, then the Agent simply reports that fact and goes back to sleep. Only if action is required will the Agent make configuration changes.

Idempotency is core to Puppet's execution model.  The exec resource type is the only major exception to Puppet idempotency, and if used incorrectly, the exec resource can break idempotency and be the cause of unexpected behaviours and problems. In this course we'll look at how to use the exec resource correctly to maintain idempotency. 

### Slide 5 

Any command in an exec resource must be able to run multiple times without causing harm. There are three main ways for and exec resource to be idempotent.

The first way is that the command used in the resource is by nature idempotent, for example apt-get update. The second way that the exec resource can be idempotent is if it has an onlyif, unless, or creates attribute. All of these attibutes prevent Puppet from running a command unless a specific condition is met. And the third way is if the exec resource has the refreshonly=>true attribute and value, which only allows Puppet to run the command when some other resource is changed. 

### Slide 6 

Just like all Puppet resources, the exec resource has a title and one or more attributes with specified values. For more information about built-in Puppet resource tyes, you can access the Puppet Labs documentation.


### slide 7 

Let's look a simple example of the exec resource. As the title indicates, this resource applies the updatedb command to a Puppet Agent.  The update command ensures that the locate database is current. On Linux and Unix systems, the updatedb command creates or updates the database of all files on the node. On the first run of the command, the database is created, and on subsequent runs, the database is updated.  when the command concludes, the database is current. So this application of the exec resource is idempotent. In this example includes two attributes - path and command. Path is the search path used to execute the command. If you do not include the path, the command must be fully qualified because the exec resource does not inherit full paths. The second attribute in this example is command. The value of this attribute is the actual command or script that you want the exec resource to execute. If you don't specifiy the command attribute, the value for the command defaults to the resource's title. Because the name of the resource and the command are the same in this example, it is not actually necessary to include the command attribute.

### Slide 8

This next example shows an application of the exec resource that is not idempotent. Here the resource is executing the command to extract application files. However, there is indicator that tells Puppet to check to see whether the files have been extract already.  

### Slide 9

To make this use of the exec resource idempotent, we can add two attributes. The c w d attribute specifies the directory from which to execute the command. And the creates attribute tells Puppet to look to see if the files have been extracted. If the files do not exist, Puppet executes the command. If the files exist, Puppet does nothing.


### slide 10

Now let's take a look at an example that is a little more detailed. And with that detail comes some possible complications. Here we have an exec resource that generates a g zipped tar file of archived log files.  The creates attribute specifies that a file named archivedlogs.tar.gz will be generated in the /mnt/logs directory.  However, if the archive file already exists, the exec resource will see that there is a file by that name and will do nothing because the node will be in the desired state. And the log files will be archived only once, which is probably not the intended outcome. We could use another the exec resource to move the archive log file to a different location, once it is created, and chain together the exec resources. But using a collection of exec resources to manage tasks can be confusing. It works fine for simple tasks, but once your exec resource collection gets so complex that you have to work to understand what’s being accomplished, you should consider another solution.


### slide 11

Rather than chaining exec resources together, we can ensure all operating system level actions are provisioned in a script, and use the exec resource to call that script. When you call a script from the exec resource, you need to ensure that the script operates as idempotently as possible. In this example, the exec resource calls a script named 'processlogfiles' which could be written to archive log file and move the files to a storage location. Then the exec resource returns a status code to indicate success or failure.

### Slide 12

While you may have a situation where exec resource is your only or best option, most often it is better to use built-in Puppet resources to achieve the desired state because the idempotency iassured. As mentioned earlier in this course, one way to ensure that you preserve idempotency when you use the exec resource is to restrict the run conditions with the attribute onlyif.

In this example, the exec resource starts the postfix email service, but only if the result of the hostname command contains the text 'mail'. But why not use Puppet code to start the mail service if the node has the mail server role defined?   Both solutions achieve the same goal,  but the Puppet code version is easier to read, understand, and maintain.

### Slide 13

When used carefully and appropriately, exec resources are your secret weapon in automating your infrastructure. Exec resources can be utilised to achieve results where there is no native or module-contributed resource type.

### Slide 14

To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.

### Slide 15

Thank you for completing this Puppet Labs Workshop course.


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
	

## References
* [Puppet Forge](http://forge.puppetlabs.com)
* [Puppet Labs Docs - Type Reference](http://docs.puppetlabs.com/references/latest/type.html)
* [Style Guide - Docs](http://docs.puppetlabs.com/guides/style_guide.html)
