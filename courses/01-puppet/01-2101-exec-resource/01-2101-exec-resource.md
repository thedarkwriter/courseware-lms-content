# The Exec Resource

The exec resource can prove very useful in Puppet Manifests, allowing the writer to access Operating System level commands, and execute scripts.  The exec resource is particularly useful where there is no available  Puppet Resource type to perform the necessary function.  However, the exec resource must be used with care.

This short course explains how to apply the exec resource appropriately, and how to ensure that the utilisation of this resource maintains idempotency of your containing Puppet manifests.  We recommend that you have already completed the Puppet Resources LMS module before commencing this course as the content is aimed at an intermediate level of Puppet knowledge.

## Slide [1] Idempotency

Idempotency refresher.
[show idempotency explanation graphic]

### commentary

Idempotency is...

Puppet by nature is idempotent, however if used incorrectly, the exec resource can break idempotency, in this course we'll show you how to use the exec resource correctly, identify some common gotchas, and show you how you can mitigate against these.


### Slide [2] Simple_Example
Simple Exec Resource example.

There are four main components of the exec resource:

exec { 'updatedb':
  provider => shell,
  path     => '/usr/sbin',
  command  => 'updatedb',
}


### commentary

This simple exec resource to ensure the updatedb command gets applied to an agent node. On Linux and Unix systems, the updatedb command creates or updates the database of all files on the node.  On the first run of the command, the database is created, and on subsequent command runs the database is updated.  The database is referenced when the System Administator issues the locate command.

The first key component of this exec resource is the resource title: updatedb.  Exec resource definitions, in common with all other Puppet resource definitions, require a title.

Secondly there is the the Provider attribute.  The provider attribute can be one of: posix, shell, or windows.  The posix provider can be used on posix compliant Unix operating systems including: HP-UX, Solaris, AIX and Tru64.  

The shell provider can be used on Linux, or non-posix compliant Unix operating systems.

The windows provider is used on versions of Microsoft Windows where the Puppet agent is supported.

The Path attribute contains the elements of the operating system path necessary for the command, specified in the command attribute to run.  It is important to note that when Puppet runs the exec resource that all necessary path elements are provided by the Manifest author in the Path attribute otherwise the resource may fail.  The exec resource does not inherit a full path from the shell process in which the exec runs.  This is why specifying all necessary path elements is important.

Lastly there is the command attribute, this specifies the executable binary or shell script, or windows batch file that the exec resource will attempt to run. 
Note that while there is no Powershell provider for the core Puppet exec resource, there are a number of implementations of a Powershell provider available on the Puppet forge.   

### Slide [3] Further_Attributes

Further exec attributes.



exec { 'archivelogfiles':
  provider => 'shell',
  path     => '/bin',
  cwd      => '/mnt/logs/',
  command  => 'tar czvf archivedlogs.tar.gz /var/log/importantapp',
  creates  => '/mnt/logs/archivedlogs.tar.gz',
}

### commentary


In this example, we have an exec resource to generate a gzipped tar file of archived log files.

The cwd attribute of the exec resource specifies the current working directory in which to perform the archive.

The creates attribute of the exec resource indicates that a file will be produced in the /mnt/logs directory called 'archivedlogs.tar.gz.'

However, if this file already exists then the exec will fail.  Therefore another mechanism is needed to move the file once it is created to a different location.

This could be another exec resource, a script, or a cron job.  We could chain the exec resource to another like this:



### Slide [4] Log_File_Processing

Calling A Script To Process Log Files.

exec { 'processlogfiles':
  provider => 'shell',
  cwd      => '/usr/bin',
  path     => '/usr/bin',
  command  => 'processlogfiles.sh',
  returns  => ['0','1','2'],
}  

### commentary

Rather than chaining exec resources together, we can ensure all operating system level actions are provisioned in a script, and use exec to call that instead.
This leads to a lack of visibility into what the script is doing, but the script can log output appropriately if that's included.

In the case where you use an exec resource to call a Bash script, or a Windows bat file, or a powershell script to perform operating system level tasks on your nodes, you need to ensure that the script operates as idempotently as possible.  Specifically, given our log files example, this means that the script needs to check for a lockfile from a previous run, and exit appropriately if that hasn't been removed.  Then it needs to create the lockfile, if one wasn't found.  Next the log processing needs to occur, and the archived logfile needs to be moved.
Finally, the lockfile needs to be removed and the script must exit with an appropriate exit code.  In this example, '0' indicates success, '1' indicates lockfile found, and '2' indicates archivelogfile not present.  

***Show Flowchart Graphic***


### slide [5] Exec Cron.allow example

Adding the root user to the cron.allow file, and trapping the result with unless.

Exec resource using Unless.

  exec { "/bin/echo root >> /etc/cron.allow":
          path   => ['/usr/bin','/usr/sbin','/bin'],
          unless => "grep root /etc/cron.allow 2>/dev/null"
  }

### commentary 

In this example, we are adding the root user to the cron.allow file, which controls which users have a crontab file, to which cron jobs may be added.

The exec resource makes the check whether the root user is already present in the cron.allow file via a grep.  Note that the path attribute contains an array of path elements required by the command, enclosed by square brackets.  If the root user is already present in the file then the exec resource will not fire.

An alternative to this exec would be the following Puppet file resource. 

### slide [6] Using the unless attribute

Exec Resource Using Unless.

 exec { "/bin/echo root >> /etc/cron.allow":
          path   => ['/usr/bin','/usr/sbin','/bin'],
          unless => "grep root /usr/lib/cron/cron.allow 2>/dev/null"
  }
  
 Puppet File Resource Alternative.
 
 file { '/etc/cron.allow':
   ensure  => file,
   content => "root\n",
 }
 

### commentary

Here is another example demonstrating how it is better to use native Puppet resources to achieve a desired state idempotently, rather than relying on exec resources.  Using the content attribute in the file resource, the content of the file can be populated as we desire.  Note the use of double quotes, which allow the \n control character to force a newline in the file after the root user text.

Both the exec resource and the file resource here achieve the same goals, but it is clear that the Puppet file resource does this more elegantly than the exec resource shown.



### slide [7] Using the onlyif attribute

Exec Resource Using OnlyIf

exec { 'enablemail':
  path    => '/usr/sbin/postfix',
  command => 'service postfix start',
  onlyif  => 'hostname|grep -i mail',
}

### commentary

In this example, the exec resource starts the postfix email service, but only if the result of the hostname command contains the text 'mail' or 'MAIL.'

A better way to do this would be to use Puppet code to introspect the role of the server, and start the postfix service if the $role variable is set as a mail server.

### slide [8] Using exec onlyif attribute vs. variable introspection

Exec Resource Using OnlyIf

exec { 'enablemail':
  path    => '/usr/sbin/postfix',
  command => 'service postfix start',
  onlyif  => 'hostname|grep -i mail',
}

Puppet alternative via introspection of $role variable.

if $role =~ /mail/ {
  service { 'postfix':
    enabled => true,
    ensure  => 'running',
    }
}



### Conclusion

When used carefully and appropriately, exec resources are your secret weapon in automating your infrastructure.  Exec resources can be utilised to achieve results where there is no native or module-contributed resource type.

### Quiz

TBC