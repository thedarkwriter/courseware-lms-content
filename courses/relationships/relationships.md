!SLIDE[bg=_images/background.png] center inverse
<script type="text/javascript" src="file/_files/shared/timeline.js"></script>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">
<link rel="stylesheet" href="file/_files/shared/slides.css">

## Relationships

!SLIDE slide2
<script> 
audio("slide2")
timeline([2000,3000,4000,5000,6000,7000],"slide2")
</script>

# Resource

<div class="time3 col-xs-6">

## Service

</div>
<div class="time5 col-xs-6">

## Service

</div>
<div class="container">
<div class="col-xs-5">
<div class="parent">
<div class="time1 img1">

![file](_images/resource_file.png)

</div>
<div class="time2 img2">

![service](_images/resource_service.png)

</div>
<div class="time3 img3">

![package](_images/resource_package.png)

</div>
</div>
</div>

<div class="col-xs-5">
<div class="parent">
<div class="time4 img1">

![service](_images/resource_service.png)

</div>
<div class="time5 img2">

![package](_images/resource_package.png)

</div>
<div class="time6 img3">

![file](_images/resource_file.png)

</div>
</div>
</div>
</div>
</div>
<div class="time1 col-xs-3">

## File

</div>
<div class="time2 col-xs-3">

## Package

</div>
<div class="time6 col-xs-3">

## File

</div>
<div class="time4 col-xs-3">

## Package

</div>

!SLIDE slide3
<script> 
audio("slide3")
timeline([17000],"slide3")
</script>

# A Package

    @@@ Puppet
    package { ‘openssh-server’:
      ensure => present,
      before => File[’/etc/ssh/sshd_config’],
    }

.break

<div class="time1 col-xs-1">
<div class="row">
<div class="col-xs-1">
</div>
<div class="col-xs-1">

[fa-long-arrow-up fa-5x]

</div></div></div>

<div class="time1 col-xs-12">

## Relationship metaparameter

</div>

!SLIDE slide4
<script> 
audio("slide4")
timeline([1000,1000,11000,14000,15500],"slide4")
</script>

# Metaparameters

<div class="time2 align-center big">

Metaparameters

</div>
<div class="time1 align-center big">

4

</div>

<div class="time3 align-center">

## Resource reference (or array of references)

</div>

<div class="time4 align-center">

[fa-long-arrow-down fa-5x]

</div>

<div class="time5 align-center">

## One or more target resources

</div>

!SLIDE slide5
<script> 
audio("slide5")
timeline([3500,6500,19500,25500],"slide5")
</script>

# Relationship Metaparameters

<div class="row">
<div class="time1 col-xs-2">

## `before`

</div>

<div class="time3 col-xs-offset-1 col-xs-10">

## Causes a resource to be applied before the target resource.

</div>
</div>

<div class="row">
<div class="time2 col-xs-2">

## `require`

</div>
<div class="time4 col-xs-offset-1  col-xs-10">

## Causes a resource to be applied after the target resource.

</div>
</div>

!SLIDE slide6
<script> 
audio("slide6")
timeline([250,750,10000,11000],"slide6")
</script>


# Relationship Metaparameters

<div class="row">
<div class="time1 col-xs-2">

## `notify`

</div>

<div class="time2 col-xs-offset-1 col-xs-10">

## Causes a resource to be applied before the target resource. The target resource will refresh if the notifying resource changes.

</div>
</div>
<div class="row">
<div class="time3 col-xs-2">

## `subscribe`

</div>
<div class="time4 col-xs-offset-1  col-xs-10">

## Causes a resource to be applied after the target resource. The target resource will refresh if the target resource changes.

</div>
</div>

!SLIDE slide7
<script> 
audio("slide7")
timeline([2500,3500,4000],"slide7")
</script>


# Requirement

<div class="huge align-center time1"> 

2 Resources

</div>
<div class="time2 align-center">

[fa-long-arrow-down fa-5x]

</div>
<div class="time3 align-center huge">

Order Matters

</div>

!SLIDE slide8
<script> 
audio("slide8")
timeline([2000,5000,5250],"slide8")
</script>

# Requirement

<div class="huge align-center">

2 Options

</div>
<div class="time1 col-xs-3 col-xs-offset-1">

## `before`

</div>
<div class="time2 col-xs-3 col-xs-offset-1">

[fa-long-arrow-right fa-5x]

</div>
<div class="time3 col-xs-3 col-xs-offset-1">

## `require`

</div>

!SLIDE slide9
<script> 
audio("slide9")
timeline([5000,9000],"slide9")
</script>

# Requirement

## before

    @@@ Puppet
    package { 'openssh-server':
      ensure => present,
      before => File['/etc/ssh/sshd_config'],
    }

.break

<div class="time1 col-xs-1">
<div class="row">
<div class="col-xs-1">
</div>
<div class="col-xs-1">

[fa-long-arrow-up fa-5x]

## Metaparameter

</div>
</div>
</div>
<div class="time2 col-xs-offset-3 col-xs-1">
<div class="row">

[fa-long-arrow-up fa-5x]

## Target resource

</div>
</div>

!SLIDE slide10
<script> 
audio("slide10")
timeline([9000,17250],"slide10")
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

.break

<div class="time1 col-xs-1">
<div class="row">
<div class="col-xs-1">
</div>
<div class="col-xs-1">

[fa-long-arrow-up fa-5x]

## Metaparameter

</div>
</div>
</div>
<div class="time2 col-xs-offset-3 col-xs-1">
<div class="row">

[fa-long-arrow-up fa-5x]

## Target resource

</div>
</div>



!SLIDE slide11
<script> 
audio("slide11")
timeline([8000,14000],"slide11")
</script>

# Ordering Arrows (Chaining Arrows)

<div class="align-center huge">

`->`

</div>

    @@@ Puppet
    Package['openssh-server'] -> File['/etc/ssh/sshd_config']

.break

<div class="time1">

* The resource on the left to be applied before the resource on the right.

</div>

<div class="time2">

* Written with a hyphen and a greater-than sign.

</div>

!SLIDE slide12
<script> 
audio("slide12")
timeline([6500,14750],"slide12")
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

.break

<div class="time1 col-xs-1">
<div class="row">
<div class="col-xs-1">
</div>
<div class="col-xs-1">

[fa-long-arrow-up fa-5x]

## Metaparameter

</div>
</div>
</div>
<div class="time2 col-xs-offset-2 col-xs-1">
<div class="row">

[fa-long-arrow-up fa-5x]

## Target resource

</div>
</div>

!SLIDE slide13
<script> 
audio("slide13")
timeline([750,6750],"slide13")
</script>

# With refresh

## subscribe

    @@@ Puppet
    service { 'sshd':
      ensure    => running,
      enable    => true,
      subscribe => File['/etc/ssh/sshd_config'],
    }

.break

<div class="time1 col-xs-1">
<div class="row">
<div class="col-xs-1">
</div>
<div class="col-xs-1">

[fa-long-arrow-up fa-5x]

## Metaparameter
</div>
</div>
</div>
<div class="time2 col-xs-offset-2 col-xs-1">
<div class="row">

[fa-long-arrow-up fa-5x]

## Target resource

</div>
</div>

!SLIDE slide14
<script> 
audio("slide14")
timeline([9000,13000],"slide14")
</script>

# Notification arrow (Chaining Arrows)

<div class="align-center huge">

`~>`

</div>

    @@@ Puppet
    File['/etc/ntp.conf'] ~> Service['ntpd']

.break

<div class="time1">

* Written with a tilde and a greater-than sign.

</div>
<div class="time2">

* Causes the resource on the left to be applied first, and sends a refresh event to the resource on the right if the left resource changes.

</div>

!SLIDE slide15
<script> 
audio("slide15")
timeline([7750,13500,21000,25000,31000,39000],"slide15")
</script>

# In Summary:  Metaparameters

<div class="col-xs-5 col-xs-offset-1">
<div class="big">

Before

</div>
<div class="time1 col-xs-offset-1">

## `before`

</div>
<div class="time3 col-xs-offset-1">

## `notify`\*

</div>
<div class="time4 col-xs-offset-5">

\* With refresh

</div>
</div>

<div class="col-xs-5 col-xs-offset-1">
<div class="big">

After

</div>
<div class="time2 col-xs-offset-1">

## `require`

</div>
<div class="time5 col-xs-offset-1">

## `subscribe`\*

</div>
<div class="time6 col-xs-offset-5">

\* With refresh

</div>
</div>

!SLIDE[bg=_images/background.png] center inverse slide16
<script> 
audio("slide16")
</script>

## Thanks for participating in relationships
