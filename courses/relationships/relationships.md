!SLIDE[bg=assets/background.png] center inverse

## Relationships

!SLIDE

# Resource

~~~DIV:left~~~
## Package file service
~~~ENDDIV~~~

~~~DIV:right~~~

## Package file service

~~~ENDDIV~~~

!SLIDE

# A Package

    @@@ Puppet
    package { ‘openssh-server’:
      ensure => present,
      before => File[’/etc/ssh/sshd_config’],
    }

## Relationship metaparameter

!SLIDE

# Metaparameters

## 4 Metaparameters

## Resource reference (or array of references)

[fa-arrow-down fa-5x]

## One or more target references

!SLIDE

# Relationship Metaparameters

## before: 
##    Causes a resource to be applied before the target resource.

## require: 
##    Causes a resource to be applied after the target resource.

!SLIDE

# Relationship Metaparameters

## notify: Causes a resource to be applied before the target resource. The target resource will refresh if the notifying resource changes.
## subscribe: Causes a resource to be applied after the target resource. The target resource will refresh if the target resource changes.

!SLIDE incremental

# Requirement

## 2 Resources
->
## Order Matters

!SLIDE

# Requirement

## 2 Options

~~~DIV:left~~~
## before
~~~ENDDIV~~~

~~~DIV:right~~~
## require
~~~ENDDIV~~~

!SLIDE

# Requirement

## before

    @@@ Puppet
    package { 'openssh-server':
      ensure => present,
      before => File['/etc/ssh/sshd_config'],
    }

!SLIDE

# Requirement

## require

    @@@ Puppet
    file { '/etc/ssh/sshd_config':
      ensure  => file,
      mode    => 600,
      source  => 'puppet:///modules/sshd/sshd_config',
      require => Package['openssh-server'],
    }

!SLIDE incremental

# Ordering Arrows (Chaining Arrows)

.align-center.big ->

    @@@ Puppet
    Package['openssh-server'] -> File['/etc/ssh/sshd_config']

* Causes the resource on the left to be applied before the resource on the right.
* Written with a hyphen and a greater-than sign.

!SLIDE

# With refresh

## notify

    @@@ Puppet
    file { '/etc/ssh/sshd_config':
      ensure  => file,
      mode    => 600,
      source  =>'puppet:///modules/sshd/sshd_config',
      notify  => Service['sshd'],
    }

!SLIDE

# With refresh

## subscribe

    @@@ Puppet
    service { 'sshd':
      ensure    => running,
      enable    => true,
      subscribe => File['/etc/ssh/sshd_config'],
    }

!SLIDE incremental

# Notification arrow (Chaining Arrows)

.align-center.big ~>

    @@@ Puppet
    File['/etc/ntp.conf'] ~> Service['ntpd']

* Causes the resource on the left to be applied first, and sends a refresh event to the resource on the right if the left resource changes.
* Written with a tilde and a greater-than sign.

!SLIDE incremental

# In Summary

.big Metaparameters

~~~DIV:left~~~
## Before

* before
* notify\*

~~~ENDDIV~~~

~~~DIV:right~~~
## After

* require
* subscribe\*


~~~ENDDIV~~~

.big \* With refresh


!SLIDE[bg=assets/background.png] center inverse

## Thanks for participating in relationships
