# An Introduction to puppet-lint
Puppet-lint is a static analysis tool you can use to verify that your Puppet code is free of common errors and ensure that it matches conventions described in the Puppet Labs Style Guide.

At the end of this course you will be able to:

* Check for common syntactical and stylistic errors in your manifest code.
* Use puppet-lint flags to disable selected checks.
* Incorporate puppet-lint into a Rakefile to automatically check a whole module.

## Slide Content
This will become the content for the instructional video.

### slide 1
(Course Title - no script) 

### slide 2
AUDIO: puppet-lint is a third-party tool that you can use to compare your manifest to a checklist of coding conventions. Then, puppet-lint suggests changes to help you align your code with Puppet's style guide. 

### slide 3
In this course you will see how to install puppet-lint, use puppet-lint to check a manifest, customize puppet-lint's configuration, and integrate puppet-lint into a Rakefile.

### slide 4
puppet-lint is packaged as a Ruby Gem, so you can use the RubyGems tool to install puppet-lint. 

### slide 5
After you have installed puppet-lint,  use the puppet lint command to check a specified manifest.

### slide 6
puppet-lint will list each found issue and the manifest line-number where it occurred.

### slide 7
In this example, puppet-lint tells us that: * The 'ensure' attribute is not the first attribute of our resource declaration. * The resource title 'ntp' isn't properly wrapped in single quotes. * The manifest includes String interpolation where a bare variable is sufficient.

### slide 8
On the puppet lint website, you can find specific information about the checks puppet-lint applies and the recommended fixes. 

### slide 9
The Puppet Style Guide sets the coding best practices for the Puppet Domain Specific Language, or D S L. Many of these best practices are implemented as checks by puppet lint. You can review the complete Puppet Style Guide at docs.puppet labs.com. 

### slide 10
You can use flags with the puppet-lint command to disable one or more checks. For instance, if you have long strings in your manifest and want to disable the 80 character line length check, you can add this flag to disable the check.

### slide 11
You can use a configuration file to store the list of checks you want to disable. Create a puppet-lint configuration file in your current working directory or your home directory.Include each flag on a separate line of the configuration file, and puppet-lint will discover and apply the flags when it runs. 

### slide 12
You can use puppet-lint with a Rakefile to test multiple Puppet manifests. If you include a 'require' line for puppet-lint in your Rakefile, you can run the command 'rake lint' from your manifest directory. This will run puppet-lint on all of the manifests in that directory.  

### slide 13
You can adjust puppet-lint's configuration from within the Rakefile to disable any checks you don't want to run.   

### slide 14
Puppet lint makes it easy to check your manifests against the common conventions for good Puppet code. The time you will save maintaining code is worth the effort of checking syntax and style as you work.  

### slide 15
To complete this course, work through any exercises that are found immediately below this video, and take the quiz.


## Video

## Exercises

*  Run puppet-lint on the sample manifest file.
  
`puppet-lint /etc/puppetlabs/puppet/modules/ntplint/manifests/init.pp`

* Puppet-lint will return the following list of warnings:

```
WARNING: top-scope variable being used without an explicit namespace on line 5
WARNING: double quoted string containing no variables on line 10
WARNING: string containing only a variable on line 39
WARNING: unquoted resource title on line 38
WARNING: ensure found on line but it's not the first attribute on line 40
```

*  Edit the manifest to correct these issues:

`vim /etc/puppetlabs/puppet/modules/ntplint/manifests/init.pp`

*  Run puppet-lint again to see the result:

`puppet-lint /etc/puppetlabs/puppet/modules/ntplint/manifests/init.pp`

*  Continue editing and checking until there are no remaining warnings. 

## Example Solution

```
# An example ntp class for testing puppet-lint checks

class ntplint ($servers = undef, $enable = true, $ensure = running) {

  case $::operatingsystem {
    centos, redhat: {
      $service_name    = 'ntpd'
      $conf_template   = 'ntp.conf.el.erb'
      $default_servers = [
        '0.centos.pool.ntp.org',
        '1.centos.pool.ntp.org',
        ]
    }
    debian, ubuntu: {
      $service_name    = 'ntp'
      $conf_template   = 'ntp.conf.debian.erb'
      $default_servers = [
        '0.debian.pool.ntp.org iburst',
        '1.debian.pool.ntp.org iburst',
        ]
    }
    default: {
        fail('Unrecognized operating system')
    }
  }

  if $servers == undef {
    $servers_real = $default_servers
  }
  else {
    $servers_real = $servers
  }

  package { 'ntp':
    ensure => installed,
  }

  service { 'ntp':
    ensure    => $ensure,
    name      => $service_name,
    enable    => $enable,
    subscribe => File['ntp.conf'],
  }

  file { 'ntp.conf':
    ensure  => file,
    path    => '/etc/ntp.conf',
    require => Package['ntp'],
    content => template("ntp/${conf_template}"),
  }

}
```

## Quiz
1. True or **False**: As long as your code is syntactically valid, some stylistic variation within your manifests is desirable.

2. The puppet-lint package should be installed using:
	a. Rake
	b. HomeBrew
	c. pip
	d. **RubyGems**
	
3. **True** or False: puppet-lint is a third party tool.

4. To disable a check when running puppet-lint from the command-line, you can use the following flag, replacing <check> with the name of the check you wish to disable:
	a. --disable-<check>
	b. **--no-<check>-check**
	c. --suppress-<check>-check
	d. --ignore-<check>
	
5. You can apply puppet-lint checks to multiple manifests using:
	a. **a Rakefile**
	b. puppet-dustbunny
	c. the -r flag
	d. the puppet module tool


## References
* [puppet-lint - GitHub](https://github.com/rodjek/puppet-lint)
* [Verifying Puppet: Checking Syntax and Writing Automated Tests](http://puppetlabs.com/blog/verifying-puppet-checking-syntax-and-writing-automated-tests)
* [Style Guide - Docs](http://docs.puppetlabs.com/guides/style_guide.html)
