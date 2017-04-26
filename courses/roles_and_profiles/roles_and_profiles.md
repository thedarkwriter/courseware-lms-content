!SLIDE[bg=_images/background.png] center inverse
<script type="text/javascript" src="file/_files/shared/timeline.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<link rel="stylesheet" href="file/_files/shared/slides.css">
<link rel="stylesheet" href="file/_files/shared/atelier-cave-light.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>


## Roles and Profiles

!SLIDE slide1 full
<script> 
audio("slide1")
timeline([3500,9750],"slide1")
</script>

# Roles and Profiles

<div class="row full align-items-center">
<div class="time1 col offset-2">

## Where we're headed

</div>
<div class="time2 col">

## Where we've been

</div>
</div>

!SLIDE slide2
<script>
audio("slide2")
</script>

# Classification

![Nodes with names of individual classes](_images/multi_node_declaration-components.png)

!SLIDE slide3 full
<script> 
audio("slide3")
</script>

# Classification in site.pp

<div class="row full align-items-center">
<div class="col">

    @@@ Puppet
    node ‘hermes.example.com’ {
      include network
      include users
      include exim
      include dovecot
      include roundcube
    }

.break

</div>
<div class="col">

    @@@ Puppet
    node ‘ares.example.com’ {
      include network
      include users
      include mysql
    }

.break

</div>

!SLIDE slide4
<script> 
audio("slide4")
</script>

# One node has many classes

![One node connected to several classes](_images/node-many-classes.svg)

!SLIDE slide5
<script> 
audio("slide5")
</script>

# Classification

## Many nodes = tangled mess
![Multiple nodes connected to several classes](_images/node-many-classes2.svg)

!SLIDE slide6
<script> 
audio("slide6")
</script>

![Complex graph showing multiple dependencies](_images/network-diagram-1.jpg)

!SLIDE slide7
<script> 
audio("slide7")
timeline([17000,19250,25000],"slide7")
</script>

# The Puppet Advantage

<div class="time1">

## But, this WILL happen:

</div>
<div class="time2 col-offset-2 col-10">

## BOSS: “Can you make another development tier for the devs?

</div>
<div class="time3 col-offset-2 col-10">

## Just like production, but different.”

</div>

!SLIDE slide8 full
<script> 
audio("slide8")
timeline([2600,3400],"slide8")
</script>

# Dev vs. Prod

<div class="row full align-items-center">
<div class="time1 col">

    @@@ Puppet
    node ‘hera.example.com’ {
      include network
      include users
      include apache
      include mysql
      include memcache
      include jdk
      include tomcat
      class { ‘php’:
        loglevel => ‘debug’,
      }
    }

.break

</div>
<div class="time2 col">

    @@@ Puppet
    node ‘zeus.example.com’ {
      include network
      include users
      include apache
      include php
      include memcache
      include jdk
      include tomcat
    }

.break

</div>

!SLIDE slide9
<script> 
audio("slide9")
</script>

![Complex graph showing multiple dependencies](_images/network-diagram-1.jpg)

!SLIDE slide10 full
<script> 
audio("slide10")
timeline([7000,8000,9000,10000,12000,13000,14000],"slide10")
</script>

# Roles & Profiles

<div class="center">
<div class="h1 mb-5">

Bringing clarity to chaos.

</div>

<div class="row">
<div class="time1 col">

## Puppet

</div>
<div class="time2 col">

[fa-arrow-right]

</div>
<div class="time3 col">

## Profile

</div>
<div class="time4 col"> [fa-arrow-right]

</div>
<div class="time5 col">

## Roles

</div>
<div class="time6 col">

[fa-arrow-right]

</div>
<div class="time7 col">

## Nodes

</div>
</div>
</div>

!SLIDE slide11
<script>
audio("slide11")
timeline([3000,5000,6000,7000,8000],"slide11")
</script>

# Roles & Profiles

<div class="time1">

## Don't overthink it.
</div>

<ul>
<li class="time2">

## Roles & Profiles are just modules.

</li>
<li class="time3">

## They are written in a specific way.

</li>
<li class="time4">

## They fulfill specific purposes.

</li>
<li class="time5">

## They help to promote clarity & reusability.

</li>

!SLIDE slide12
<script>
audio("slide12")
timeline([3000],"slide12")
</script>

# Roles: Structure

<div>

    @@@ render-diagram
    graph TD
    role(role)--> role_web(role::webserver)
    role(role) --> role_db(role::dbserver)
    role(role) --> role_mail(role::mailserver)

.break

</div>
!SLIDE slide13
<script>
audio("slide13")
timeline([12000,14000],"slide13")
</script>

# Roles: Classification
<div class="container">
<div class="row">
<div class="col">

    @@@ Puppet
    node ‘ares.example.com’ {
      include role::dbserver
    }
    node ‘zeus.example.com’ {
      include role::webserver
    }
    node ‘hera.example.com’ {
      include role::webdbserver
    }
    node ‘hermes.example.com’ {
      include role::webmail
    }

.break

</div>
<div class="col">
<div class="time1">

[fa-arrow-left fa-3x]

</div>
<div class="time2">

[fa-arrow-left fa-3x]

</div>
</div>
</div>
</div>

!SLIDE slide14 full
<script>
audio("slide14")
</script>

# Roles structure: Basic role

<div class="container">

    @@@ Puppet col-6 col-offset4
    class role {
      include profile::base
    }

.break

</div>

!SLIDE slide15 full
<script>
audio("slide15")
timeline([10000,14000,15000],"slide15")
</script>

# Classification

<div class="col">
</div>
<div class="col-1">
</div>
<div class="col">

![Icon representing a node](_images/node.png)

</div>

!SLIDE slide16
<script>
audio("slide16")
</script>

# Profiles: Wireframing

![One node connected to several classes](_images/node-many-classes.svg)

!SLIDE slide17
<script>
audio("slide17")
timeline([7500],"slide17")
</script>

# Profiles: Wireframing

<div class="container-fluid">
<div class="row align-items-center">

    @@@ Puppet
    class profile::web {
      include apache
      include php
      include tomcat
      include jdk
      include memcache
    }

.break

<div class="col time1">

![One profile connected to several classes](_images/profile.svg)

</div>
</div>
</div>

!SLIDE slide18
<script>
audio("slide18")
</script>

# Profiles: Wireframing

<div class="container-fluid align-items-center">
<div class="row align-items-center">
<div class="col-5">

    @@@ Puppet
    class profile::base {
      include network
      include users
    }

.break

</div>
<div class="col-7">

![Base profile connected to several classes](_images/profile_base.svg)

</div>
</div>

<div class="row align-items-center">
<div class="col-5">

    @@@ Puppet
    class profile::db {
      include mysql
    }

.break

</div>
<div class="col-7">

![DB profile connected to a single class](_images/profile_db.svg)

</div>
</div>

!SLIDE slide19
<script>
audio("slide19")
</script>

# Profiles: Round up

<div class="container-fluid">
<div class="row">
<div class="col">

![DB profile connected to a single class](_images/profile_db.svg)

![Mail profile connected to a single class](_images/profile_mail.svg)

![Base profile connected to several classes](_images/profile_base.svg)

</div>
<div class="col">

![Profile connected to several classes](_images/profile.svg)

</div>

</div>
</div>

!SLIDE slide20
<script>
audio("slide20")
</script>

# Summary

![Three nodes connected to one role, which is connected to two classes, which connect to classes](_images/roles_profiles.svg)
