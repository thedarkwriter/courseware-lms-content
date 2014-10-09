# The Exec Resource

The exec resource is a powerful tools that allows you to access operating system commands and execute scripts from within your Puppet manifests. It is especially useful when there is no available  Puppet resource type to perform a function. 

After completing this course, you will be able to apply the exec resource appropriately and ensure that you maintainthe idempotency of your Puppet manifests. 

## Slide Content

### Slide 1 - Title
The Puppet exec resource type allows you to execute operating system commands from within your Puppet manifests. It is a particularly useful tool when there is no built-in Puppet resource type to perform a task.

### Slide 2 - Objectives

In this course, we look at how to apply the Puppet exec resource appropriately to ensure that you maintain the idempotency of your Puppet manifests.  Before completing this intermediate level course, we recommend that you complete the Puppet Labs Workshop Resources course.  


### Slide 3 - Idempotency

The Puppet exec resource is sort of like a pocket knife that includes a variety of tools.  You can use it to perform many tasks. And yet it is not specially designed for any one of those tasks. Before using the exec resource, you may want to check out the Puppet Forge where there are many tried and tested modules, one of which may accomplish your task. The exec resource type allows you to access the operating system to execute commands and run scripts from within Puppet. However, it can be tricky to apply the exec resource because of the interdependencies of many of the attributes, and you may find that your results are not what you had anticipated. 


### Slide 4
Now, before we look at the exec resource in detail -  a brief review of idempotency and Puppet.  By design, Puppet resource types and providers are idempotent. They describe a desired final state rather than a series of steps to follow. So, a resource can be applied multiple times with the same outcome.  By default, every 30 minutes the Puppet Agent wakes up and makes sure that the node is configured properly. If it is already in the desired state, then the Agent simply reports that fact and goes back to sleep. Only if action is required will the Agent make configuration changes. 

Idempotency is core to Puppet's execution model.  The exec resource type is the only major exception to Puppet idempotency, and if used incorrectly, the exec resource can break idempotency and be the cause of unexpected behaviours and problems.The only major exception to Puppet idempotency is the exec resource type. In this course we'll look at how to use the exec resource correctly to maintain idempotency. 


 

### Slide 5 

Any command in an exec resource must be able to run multiple times without causing harm. There are three main ways for and exec resource to be idempotent.

The first way is that the command used in the resource is by nature idempotent, for example apt-get update. The second way that the exec resource can be idempotent is if it has an onlyif, unless, or creates attribute. All of these attibutes prevent Puppet from running a command unless a specific condition is met. And the third way is if the exec resource has the refreshonly=>true attribute and value, which only allows Puppet to run the command when some other resource is changed. 


### Slide 6 

Just like all Puppet resources, the exec resource has a title and one or more attributes with specified values. For more information about built-in Puppet resource tyes, you can access  the Puppet Labs documentation.


### slide 7 

Let's look a simple example of the exec resource. As the title indicates, this resource applies the updatedb command to a Puppet Agent.  On Linux and Unix systems, the updatedb command creates or updates the database of all files on the node. On the first run of the command, the database is created, and on subsequent command runs the database is updated.  It includes two attributes - path and command.

The path attribute is the search path used to execute the command. If you do not include the path, the command must be fully qualified because the exec resource does not inherit full paths. The second attribute in this example is command. The value of this attribute is the actual command or script that you want the exec resource to execute.The command must be either fully qualified or you must provide a path for the command. If you do not include this attribute, the value defaults to the resource's title. So, in this example, because the name of the resource and the command are the same, it is not really necessary to include the command attribute.


### slide 8

Now let's take a look at a script that is a little more detailed. And with that detail comes some possible complications. In this example, we have an exec resource that generates a g zipped tar file of archived log files.

The c w d attribute specifies the current working directory in which to perform the archive. The creates attribute specifies that a file named archivedlogs.tar.gz.will be generated in the /mnt/logs directory. However, if this file already exists, the exec resource will see that there is already a file by that name and will do nothing because the node will be in the desired state. Therefore, this application of the exec resource is not idempotent. And the log files will be archived only once, which is probably not the intended outcome.

 We need another mechanism to move the file, once it is created, to a different location.  We could use another the exec resource and chain them together. But using a collection of exec resources to manage tasks that are not  covered by a built-in resource can be confusing. It works fine for simple tasks, but once your exec resource collection gets so complex that you have to work to understand what’s being accomplished, you should consider developing a custom resource type. It will be more predictable and easier to maintain.


### slide 9

Rather than chaining exec resources together, we can ensure all operating system level actions are provisioned in a script, and use the exec resource to call that script. When you call a script from the exec resource, you need to ensure that the script operates as idempotently as possible.  Specifically, with our log files example,   the script needs to check for a lockfile from a previous run, and exit appropriately if that hasn't been removed.  Then it needs to create the lockfile, if one wasn't found.  Next the log processing needs to occur, and the archived logfile needs to be moved. Finally, the lockfile needs to be removed and the script must exit with an appropriate exit code.  In this example, '0' indicates success, '1' indicates lockfile found, and '2' indicates archivelogfile not present.

### Slide 10

Rather than chaining exec resources together, we can ensure all operating system level actions are provisioned in a script, and use the exec resource to call that script. When you call a script from the exec resource, you need to ensure that the script operates as idempotently as possible.  Specifically, with our log files example,   the script needs to check for a lockfile from a previous run, and exit appropriately if that hasn't been removed.  Then it needs to create the lockfile, if one wasn't found.  Next the log processing needs to occur, and the archived logfile needs to be moved. Finally, the lockfile needs to be removed and the script must exit with an appropriate exit code.  In this example, '0' indicates success, '1' indicates lockfile found, and '2' indicates archivelogfile not present.

### Slide 11

While you may have a situation where exec resource is your only or best option, most often it is better to use native Puppet resources to achieve the desired state because idempotency is inherent to Puppet. As mentioned earlier in this course, one way to ensure that you preserve idempotency when you use the exec resource is to restrict the run conditions with the attribute onlyif.

In this example, the exec resource starts the postfix email service, but only if the result of the hostname command contains the text 'mail' or 'MAIL.' Although both solutions achieve the same goal, why not use Puppet code to introspect the role of the server, and start the postfix service if the $role variable is set as a mail server. The Puppet code version is easier to read, understand, and maintain.


### Slide 12

When used carefully and appropriately, exec resources are your secret weapon in automating your infrastructure. Exec resources can be utilised to achieve results where there is no native or module-contributed resource type.

### SLide 13

To check your knowledge, click the link on the bottom of this course's page and complete the short quiz. There is also a link to additional learning resources.

### SLide 14 

Thank you for completing this Puppet Labs Workshop course.