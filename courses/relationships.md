# Relationships
The order of resources in a Puppet manifest does not matter. Puppet assumes that most resources are not related to each other and will manage the resources in whatever order is most efficient.

If a group of resources should be managed in a specific order, you must explicitly declare the relationships.

### Metaparameters
Some *attributes* in Puppet can be used with every resource type. These are called metaparameters. They don’t map directly to system state; instead, they specify how Puppet should act toward the resource.

The most commonly used metaparameters are for specifying order relationships between resources.

At the end of this course you will be able to:

* list the 4 metaparameters used to specify resource relationships
* compare & contrast the differences between `before` & `require` AND `notify` & `subscribe`

## Video ##
[Link to Video](http://linktovideo)

## Exercises ##
There are no exercises for this course.

## Quiz ##
1. True or False. Resource order matters. (False)
2. There are four relationship metaparameters. Which of the following is not one:
a. `before` b. `after` c. `notify` d. `subscribe` (b)
3. If two resources need to happen in order, you can either put a `before` attribute in the prior one or **which** attribute in the subsequent one? Either approach will create the same relationship.
a. `after` b. `notify` c. `require` d. `subscribe` (c)
4. You can create relationships between two resources or groups of resources using the `->` and `~>` operators. In the following example,  the `Package` resource is applied before or after the `File` resource.
`Package['openssh-server'] -> File['/etc/ssh/sshd_config']`
a. before b. after (a)
5. True or False. In the following example, the resource `file` will be applied *before* the target resource `Service` AND the target resource will refresh if the notifying resource changes. (True)

## Resources ##
* [Language Relationships](http://docs.puppetlabs.com/puppet/2.7/reference/lang_relationships.html)    # /etc/puppetlabs/code/modules/zsh/manifests/init.pp
    class zsh {
      package { ‘zsh’:
        ensure => present,
        before => File[‘/etc/zshrc’],
      }
      file { ‘/etc/zshrc’:
        ensure  => file,
        owner   => ‘root’,
        group   => ‘root’,
        # The relationship could also be expressed with
        #require => Package['zsh'],
        source  => ‘puppet:///modules/zsh/zshrc’,
      }

      # The relationship could also be expressed with
      #Package[‘zsh’] -> File[‘/etc/zshrc’]
    }
