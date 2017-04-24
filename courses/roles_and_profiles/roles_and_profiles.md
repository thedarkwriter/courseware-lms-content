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
