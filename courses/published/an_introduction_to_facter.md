# An Introduction to Facter
Facter is Puppet’s cross-platform system profiling library. It discovers and reports per-node facts, which are available in your Puppet manifests as variables.

At the end of this course you will be able to:

* describe the type of information stored in Facter.
* demonstrate how to view the information stored in Facter.

## Video
[Link to Video](https://github.com/puppetlabs/courseware-lms/blob/master/03-Technologies/4101/03-4101-Facter_Intro.mp4)

## Transcript

## Slide 0



## Slide 1


                      

## Slide 2

It discovers and reports per-node facts, which are available in your Puppet manifests as variables.

## Slide 3



## Slide 4

To see the actual available facts (including plugins) and their values on any of your systems, run facter -p at the command line. If you are using Puppet Enterprise, you can view all of the facts for any node on the node’s page in the console.

## Slide 5

Facts appear in Puppet as normal top-scope variables. This means you can access any fact for a node in your manifests with $<fact name>. (E.g. $osfamily, $memorysize, etc.)

    When using facts in a puppet manifest, preface with $:: to explicitly specify top scope.

## Slide 6

You can add new facts by writing a snippet of Ruby code on the Puppet master. We then use Plugins In Modules to distribute our facts to the client.

More information in the Custom Facts course.

## Slide 7

External facts are available only in Facter 1.7 and later.
What are external facts?
External facts provide a way to use arbitrary executables or scripts as facts, or set facts statically with structured data. If you’ve ever wanted to write a custom fact in Perl, C, or a one-line text file, this is how.

More information in the External Facts course.

## Slide 8





## Exercises
1. Run facter to gather a list of all known facts

`facter`

2. Run facter to determine the fqdn, the network interfaces, and the IP address for eth0

*   `facter fqdn`
*   `facter interfaces`
*   `facter ipaddress_eth0`

3. The `/etc/motd` file is presented to users each time they log in. We would like to customize this login message to contain information about the current host.

We've set up your environment on the master and mapped that directory to the `/root/puppetcode` directory of your agent.
Change your current working directory to your fileshare with:

`cd /root/puppetcode/modules`

4. Examine the directory structure of the example motd module.

<pre>[root@training modules]# tree motd/
motd/
├── manifests
│   └── init.pp
├── Modulefile
├── README
├── spec
│   └── spec_helper.rb
└── tests
    └── init.pp
</pre>

Update the motd module’s main class manifest file to set the content of your `/etc/motd` file to a message that includes the node’s `hostname` and `operatingsystem`. **Remember****:** Strings must use double quotes in order for variables to be interpolated.

`vim motd/manifests/init.pp`

5. Validate your syntax and enforce your class. and apply the class. Your `/etc/motd` file should contain the facts you specified. For testing locally you'll want to specify the current directory as the modulepath for `puppet apply`.

*   `puppet parser validate motd/manifests/init.pp`
*   `puppet apply motd/tests/init.pp --modulepath=.`

6. Now that you've tested it, you can add the class to your environment's init.pp on the master:
*   `vim /root/puppetcode/manifests/init.pp`
*   Add the line `include motd` inside the default node definition

7. Since you've already applied the manifest locally, running puppet agent won't change anything. So you'll need to change the message.
*   `vim motd/manifests/init.pp
*   Add a few words to the content of /etc/motd.

8. Run the puppet agent.
*   `puppet agent -t`


## Quiz
1. True or False. Facter stores information about the Puppet Master for your system. (False)
2. Facter stores **facts** as pairs of:
a. variables & values b. keys & values c. node names & values d. resource names & values (b)
3. True or False. Custom facts can be written using Ruby. (True)
4. Facts are top-scope variables. What is considered a best practice for accessing facts in your manifests?
a. $factname b. "$factname" c. ${::factname} d. {$factname} (c)
5. True or False. External facts provide a way to use arbitrary executables or scripts as facts. (True)

## Resources
* [Facter - GitHub](https://github.com/puppetlabs/facter)
* [Puppet Labs Docs](http://docs.puppetlabs.com/facter/)
* [Facter Project Home](http://projects.puppetlabs.com/projects/facter)
* [Facter Homepage](http://puppetlabs.com/puppet/related-projects/facter/)
