# An Introduction to the Command Line
This course is an introduction to using the command line to communicate with your Linux environment.  

At the end of this course you will be able to:

* Describe basic differences between Windows and Linux platforms.
* Access a bash shell.
* Navigate the Linux directory structure.
* Invoke basic Linux commands.

## Slide Content

### slide 1
(Title slide)
This course is an introduction to using the command line to communicate with your unix-like environment. If you are new to the Linux or unix, we recommend you complete this course before participating in the Puppet Fundamentals or the Puppet Fundamentals for Windows courses. 


### slide 2
For simplicity, and because Linux is one of the most common unix-like derivatives, during the rest of this course we use Linux to refer to all unix-like operating platforms.

### slide 3
In this course, we'll review some similarities and differences between Windows and Linux. Then we'll see how to access a bash shell to communicate with the Linux environment from the command line. how to navigate the linux directory structure, and how to invoke some basic linux commands that you'll need to manage Puppet Enterprise.

### slide 4We'll present and demonstrate some basic Linux concepts and commands. If you want, you can access a private, virtual testing environment to follow along and practice during the course.  And you can practice on your own after the presentation.  At the end of the course, there is a quiz, for you to check your understanding. You can access the quiz and a link to additional resources on the course web page.

### slide 5
Puppet Enterprise is IT automation software that gives system administrators the power to easily automate repetitive tasks, quickly deploy critical applications, and proactively manage infrastructure, on-premises or in the cloud. And while Puppet Enterprise runs in blended environments, including on all major unix-like platforms and Microsoft Windows, there are elements that you can only manage from a linux or unix server. As a Puppet Enterprise system administrator, you'll need some tools to help you navigate your linux environment.  

### slide 6
First,  you should be aware of some similarities and differences between Windows and Linux. One obvious difference is the interface. In Windows it is most common to manage the environment through a gooey, and in Linux it is more common to use the command line. 

### slide 7
Another significant difference between Windows and Linux is how you refer to and move around in the file structure. In Windows you use folders, and in Linux there are directories. In Windows, if you want, you can view all of your files and folders at once through the gooey.  To move around in windows, you point and click with the mouse. In general, Linux users do not use a gooey to manage the environment. In Linux, the directory structure is usually represented hierarchically, with a tree diagram. To move around in the Linux directory structure, you type commands at the command line. The root directory is the highest level directory in the linux environment.  As a regular user, you have a home directory, which is the highest level directory for your login name. 

### slide 8
You also need to know a few Linux file and directory naming conventions. In the Linux environment, a file name is the full path name for that file. And, all names for all files and directories are always case sensitive. To avoid confusion, it is best not to use spaces in Linux file and directory names. And most special characters are reserved. A common Linux naming convention is the use of underscores to make names more readable. And, In the Linux environment, you cannot give a file the same name as the directory in which it resides. (Need to rewrite and re-record - should state that you cannot have a file and a directory of the same name in the same directory.)

### slide 9
Now let's take a look at some of the ways in which Windows and Linux are similar. Both Windows and Linux let you define users that have elevated priviledges. These users can perform administrative tasks that regular users are not allowed to perform. In Linux, Root is the most elevated user,  and has global privledges. You will rarely, if ever, need to complete work as the root user. When you need to complete a particular Linux administrative task, such as adding a user account, you change your login to an elevated user that has priviledges associated with the task you need to complete. 

### slide 10
Another similarity between Windows and Linux is the use of a shell to access the command line. In windows, you may be used to using PowerShell. In Linux, bash is the commonly used shell and the one we use in this and most other Puppet Labs courses.  

### slide 11
To practice the skills presented in this course, you need an s s h connectivity tool to open a bash shell and securely access the Linux server where we have Puppet Enterprise installed for you. There are several good tools that you can download for free from the the internet. In this course we use PuTTY. If you don't yet have Putty or a different tool installed, you may want to go ahead and pause the course now and install one. 

### slide 12
Now, to access a bash shell, launch PuTTY, or the SSH connectivity tool that you're using. With PuTTY, you see the PuTTY Configuration dialog box display. To access the  virtual testing environment that we set up for you, click the Try it out Launch button from this course's web page. Use the address provided to access a shell. If you want to follow along and practice the commands as they are presented, go ahead and pause now and access the bash shell. Or, you can wait and to access a shell when you start the practice session.  

### slide 13
When a command shell opens, you can securely log in to your linux server. Although it is not the common practice to work as root, To access the testing environment that we have set up, you will need to log in as root user with the password puppet.  

### slide 14
After you successfully accessed the environment, you'll see a window that looks something like this, with a message about the system.  And now let's look at some basic linux commands. First, to clear the screen, type the clear command. Next, to see the name of the logged in user, type Who Am I. And to display your computer's name or host, you can type hostname. If you want to display this month's calendar, type cal - c a l. And to display the current date and time, type  type date. Notice that after it invokes each command, the system returns you to the command line prompt, displaying the current user login. 

### slide 15
There are several forms of help available for the command line. STo display information about a specific command, use the man command, short for manual. If you type only the word man, the system prompts you for more information. If you type man l s, the system displays this man page. To exit the page, type the letter q. When you exit man pages, the system returns you to the command line and displays the last command you invoked. But let's say that you don't know the exact command you need to use. You only know that you want to create a new directory. You can use the apropos command, with a keyword, such as directories. The system displays a man page with command information related to the keyword.  

### slide 16
Okay, now let's take a look at some basic linux commands that will help you manage your Puppet Enterprise environment. We'll start with directory commands.  

### slide
The core of the Puppet language is the resource declaration. A resource 

### slide
The core of the Puppet language is the resource declaration. A resource 

### slide
The core of the Puppet language is the resource declaration. A resource 

### slide
The core of the Puppet language is the resource declaration. A resource 

### slide
The core of the Puppet language is the resource declaration. A resource 

### slide
The core of the Puppet language is the resource declaration. A resource 

### slide
The core of the Puppet language is the resource declaration. A resource 

### slide
The core of the Puppet language is the resource declaration. A resource 

### slide
The core of the Puppet language is the resource declaration. A resource 

## Exercises
1. Execute the `puppet resource` command to query the `users` on your system. (Use the Learning VM or your own personal puppet installation.)

## Quiz
1. True or False. There are elements of Puppet Enterprise that you can only manage from a Linux or unix server. 
	**True**
2. Which one of the following commands displays a list of Linux directory commands?  
	a. man directories
	b. **apropos directories**
	c. man dir
	d. mkdir
	e. apropos
3. Which of the following commands can you use to to move around in Linux directories? Select all that apply.
	a. **cd <directory_name>**
	b. changedir <directory_name>
	c. **cd <directory_name/sub_directory_name>**
	d. **cd**
	e. chdir <directory_name>
4. Which one of the following items best describes the information the system displays when you invoke the **tree** command?
	a. a listing of the files in the current directory
	b. a listing of the sub-directories in the current directory
	c. a hierarchical diagram of all user home directories on the server
	d. **a hierachical diagram of the sub-directories in the current directory**
5. True or False. All Linux file and directory names are case sensitive.
	**True**

## References
* [Docs](http://docs.puppetlabs.com/puppet/2.7/reference/lang_resources.html)
* [Resource Abstraction Layer](http://docs.puppetlabs.com/learning/ral.html)
* [Puppet Core Types Cheatsheet - PDF](http://docs.puppetlabs.com/puppet_core_types_cheatsheet.pdf)