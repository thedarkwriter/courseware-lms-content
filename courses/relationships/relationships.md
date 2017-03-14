!SLIDE[bg=assets/background.png] center inverse
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="/file/assets/slides.css">

## Relationships

!SLIDE slide2
<script> 
audio("slide2")
timeline([1000,2000,3000,4000,5000,6000],"slide2")
</script>

# Resource


~~~DIV:time3 col-xs-6~~~
## Service
~~~ENDDIV~~~
~~~DIV:time5 col-xs-6~~~
## Service
~~~ENDDIV~~~
~~~DIV:container~~~
  ~~~DIV:col-xs-6~~~
    ~~~DIV:parent~~~
      ~~~DIV:time1 img1~~~
        ![file](assets/resource_file.png)
      ~~~ENDDIV~~~
      ~~~DIV:time2 img2~~~
        ![service](assets/resource_service.png)
      ~~~ENDDIV~~~
      ~~~DIV:time3 img3~~~
        ![package](assets/resource_package.png)
      ~~~ENDDIV~~~
    ~~~ENDDIV~~~
  ~~~ENDDIV~~~

  ~~~DIV:col-xs-6~~~
    ~~~DIV:parent~~~
      ~~~DIV:time4 img2~~~
        ![service](assets/resource_service.png)
      ~~~ENDDIV~~~
      ~~~DIV:time5 img3~~~
        ![package](assets/resource_package.png)
      ~~~ENDDIV~~~
      ~~~DIV:time6 img1~~~
        ![file](assets/resource_file.png)
      ~~~ENDDIV~~~
    ~~~ENDDIV~~~
  ~~~ENDDIV~~~
~~~ENDDIV~~~
~~~DIV:time1 col-xs-3~~~
## File
~~~ENDDIV~~~
~~~DIV:time2 col-xs-3~~~
## Package
~~~ENDDIV~~~
~~~DIV:time6 col-xs-3~~~
## File
~~~ENDDIV~~~
~~~DIV:time4 col-xs-3~~~
## Package
~~~ENDDIV~~~

!SLIDE slide3
<script> 
audio("slide3")
</script>

# A Package

    @@@ Puppet
    package { ‘openssh-server’:
      ensure => present,
      before => File[’/etc/ssh/sshd_config’],
    }

## Relationship metaparameter

!SLIDE slide4
<script> 
audio("slide4")
timeline([1000,1000,11000,14000,15500],"slide4")
</script>

# Metaparameters

~~~DIV:time2 align-center~~~
## Metaparameters
~~~ENDDIV~~~
~~~DIV:time1 align-center~~~
4
~~~ENDDIV~~~

~~~DIV:time3 align-center~~~
## Resource reference (or array of references)
~~~ENDDIV~~~

~~~DIV:time4 align-center~~~
[fa-arrow-down fa-5x]
~~~ENDDIV~~~

~~~DIV:time5 align-center~~~
## One or more target references
~~~ENDDIV~~~

!SLIDE slide5
<script> 
audio("slide5")
timeline([3500,6500,20000,25500],"slide5")
</script>

# Relationship Metaparameters

~~~DIV:row~~~
~~~DIV:time1 col-xs-2~~~
## `before`
~~~ENDDIV~~~

~~~DIV:time3 col-xs-offset-1 col-xs-10~~~
## Causes a resource to be applied before the target resource.
~~~ENDDIV~~~
~~~ENDDIV~~~

~~~DIV:row~~~
~~~DIV:time2 col-xs-2~~~
## `require`
~~~ENDDIV~~~

~~~DIV:time4 col-xs-offset-1  col-xs-10~~~
## Causes a resource to be applied after the target resource.
~~~ENDDIV~~~
~~~ENDDIV~~~

!SLIDE slide6
<script> 
audio("slide6")
</script>

# Relationship Metaparameters

## notify: Causes a resource to be applied before the target resource. The target resource will refresh if the notifying resource changes.
## subscribe: Causes a resource to be applied after the target resource. The target resource will refresh if the target resource changes.

~~~DIV:col-xs-6~~~
  ~~~DIV:time1 col-xs-6~~~
  ##File
  ~~~ENDDIV~~~
  ~~~DIV:time3 col-xs-6~~~
  ##Package
  ~~~ENDDIV~~~
~~~ENDDIV~~~

!SLIDE slide3
<script> 
audio("slide3")
</script>

# A Package

    @@@ Puppet
    package { ‘openssh-server’:
      ensure => present,
      before => File[’/etc/ssh/sshd_config’],
    }

## Relationship metaparameter

!SLIDE slide4
<script> 
audio("slide4")
timeline([1000,1000,11000,14000,15500],"slide4")
</script>

# Metaparameters

~~~DIV:time2 align-center~~~
## Metaparameters
~~~ENDDIV~~~
~~~DIV:time1 align-center~~~
4
~~~ENDDIV~~~

~~~DIV:time3 align-center~~~
## Resource reference (or array of references)
~~~ENDDIV~~~

~~~DIV:time4 align-center~~~
[fa-arrow-down fa-5x]
~~~ENDDIV~~~

~~~DIV:time5 align-center~~~
## One or more target references
~~~ENDDIV~~~

!SLIDE slide5
<script> 
audio("slide5")
timeline([3500,6500,20000,25500],"slide5")
</script>

# Relationship Metaparameters

~~~DIV:row~~~
~~~DIV:time1 col-xs-2~~~
## `before`
~~~ENDDIV~~~

~~~DIV:time3 col-xs-offset-1 col-xs-10~~~
## Causes a resource to be applied before the target resource.
~~~ENDDIV~~~
~~~ENDDIV~~~

~~~DIV:row~~~
~~~DIV:time2 col-xs-2~~~
## `require`
~~~ENDDIV~~~

~~~DIV:time4 col-xs-offset-1  col-xs-10~~~
## Causes a resource to be applied after the target resource.
~~~ENDDIV~~~
~~~ENDDIV~~~

!SLIDE slide6
<script> 
audio("slide6")
</script>

# Relationship Metaparameters

## notify: Causes a resource to be applied before the target resource. The target resource will refresh if the notifying resource changes.
## subscribe: Causes a resource to be applied after the target resource. The target resource will refresh if the target resource changes.

!SLIDE slide7
<script> 
audio("slide7")
</script>


# Requirement

## 2 Resources
->
## Order Matters

!SLIDE slide8
<script> 
audio("slide8")
</script>

# Requirement

## 2 Options

~~~DIV:left~~~
## before
~~~ENDDIV~~~

~~~DIV:right~~~
## require
~~~ENDDIV~~~

!SLIDE slide9
<script> 
audio("slide9")
</script>

# Requirement

## before

    @@@ Puppet
    package { 'openssh-server':
      ensure => present,
      before => File['/etc/ssh/sshd_config'],
    }

!SLIDE slide10
<script> 
audio("slide10")
</script>

# Requirement

## require

    @@@ Puppet
    file { '/etc/ssh/sshd_config':
      ensure  => file,
      mode    => 600,
      source  => 'puppet:///modules/sshd/sshd_config',
      require => Package['openssh-server'],
    }

!SLIDE incremental slide11
<script> 
audio("slide11")
</script>

# Ordering Arrows (Chaining Arrows)

.align-center.big ->

    @@@ Puppet
    Package['openssh-server'] -> File['/etc/ssh/sshd_config']

* Causes the resource on the left to be applied before the resource on the right.
* Written with a hyphen and a greater-than sign.

!SLIDE slide12
<script> 
audio("slide12")
</script>

# With refresh

## notify

    @@@ Puppet
    file { '/etc/ssh/sshd_config':
      ensure  => file,
      mode    => 600,
      source  =>'puppet:///modules/sshd/sshd_config',
      notify  => Service['sshd'],
    }

!SLIDE slide13
<script> 
audio("slide13")
</script>

# With refresh

## subscribe

    @@@ Puppet
    service { 'sshd':
      ensure    => running,
      enable    => true,
      subscribe => File['/etc/ssh/sshd_config'],
    }

!SLIDE incremental slide14
<script> 
audio("slide14")
</script>

# Notification arrow (Chaining Arrows)

.align-center.big ~>

    @@@ Puppet
    File['/etc/ntp.conf'] ~> Service['ntpd']

* Causes the resource on the left to be applied first, and sends a refresh event to the resource on the right if the left resource changes.
* Written with a tilde and a greater-than sign.

!SLIDE incremental slide15
<script> 
audio("slide15")
</script>

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


!SLIDE[bg=assets/background.png] center inverse slide16
<script> 
audio("slide16")
</script>

## Thanks for participating in relationships
