!SLIDE[bg=_images/background.png] center inverse
<script type="text/javascript" src="file/_files/shared/timeline.js"></script>

<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/css/bootstrap.min.css" integrity="sha384-rwoIResjU2yc3z8GV/NPeZWAv56rSmLldC3R/AZzGRnGxQQKnKkoFVhFQhNUwEyJ" crossorigin="anonymous">
<link rel="stylesheet" href="file/_files/shared/slides.css">
<link rel="stylesheet" href="file/_files/shared/atelier-cave-light.css">
<script src="https://cdnjs.cloudflare.com/ajax/libs/tether/1.4.0/js/tether.min.js" integrity="sha384-DztdAPBWPRXSA/3eYEEUWrWCy7G5KFbe8fFjk5JAIxUYHKkDx6Qin1DkWx51bBrb" crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-alpha.6/js/bootstrap.min.js" integrity="sha384-vBWWzlZJ8ea9aCX4pEW3rVHjgjt7zpkNpZk+02D9phzyeVkE+jo0ieGizqPLForn" crossorigin="anonymous"></script>


## Event Inspector

!SLIDE slide1 full
<script> 
audio("slide1")
timeline([3500,26000],"slide1")
</script>

# What is it?

<div class="container-fluid full">
<div class="row full align-items-center">
<div class="col-2">

![PE console image](_images/PE_console.svg)

</div>
<div class="col">
<div class="time1">

## Reporting tool

* Provides data for investigating the current state of your infrastructure

</div>
<div class="time2">

## Accomplish 2 important things

1. Monitoring a summary of the infrastructure's activity
2. Analyzing the details of important changes & failures

</div>
</div>
</div>
</div>

!SLIDE slide2
<script> 
audio("slide2")
timeline([9000,13000,22000,25000,26500,28000],"slide2")
</script>

# Events

<div class="container-fluid">
<div class="row mt-5">
<div class="col time1">

![Building block representing a resource](_images/resource.svg)

</div>
<div class="col offset-1 time2">

![Building block with dashed lines representing the desired state of a resource](_images/dashed_resource.svg)

</div>
<div class="col offset-1 time3">

![Building block representing a skipped resource](_images/skip_resource.svg)

</div>
</div>
<div class="row mt-5">
<div class="col time4">

![Building block representing a resource](_images/resource.svg)

</div>
<div class="col offset-1 time5">

![Log book](_images/log.svg)

</div>
<div class="col offset-1 time6">

![Computer screen with the puppet logo](_images/PE_console.svg)

</div>
</div>
</div>


!SLIDE slide3 full
<script> 
audio("slide3")
timeline([6750,14000,21500,43500],"slide3")
</script>

# Events

<div class="container-fluid full">
<div class="row align-items-center mt-5">
<div class="col-2 offset-1 time1">

## Change

</div>
<div class="col-2 time1">

![Nodes icon with solid line](_images/servers.svg)

</div>
<div class="col-2 offset-2 time2">

![Nodes icon with solid line](_images/server_fail.svg)

</div>
<div class="col-2 time2">

## Failure

</div>
</div>
<div class="row align-items-center mt-5">
<div class="col-2 offset-1 time3">

## Noop

</div>
<div class="col-2 time3">

![Nodes icon with dotted line](_images/servers_dotted.svg)

</div>
<div class="col-2 offset-2 time4">

![Nodes icon with skip symbol](_images/skip.svg)

</div>
<div class="col-2 time4">

## Skip

</div>
</div>
</div>

!SLIDE slide4
<script>
audio("slide4")
timeline([8500,9500,10500],"slide4")
</script>

# Perspectives

<div class="container">
<div class="row align-center m-5 align-items-end">
<div class="col-3 time1">

![Building blocks representing a class](_images/class.svg)

</div>
<div class="col-3 offset-1 time2">

![A set of nodes](_images/servers.svg)

</div>
<div class="col-3 offset-1 time3">

![Building blocks representing a resource](_images/resource.svg)

</div>
<div class="col-3 time1">

## Classes

</div>
<div class="col-3 offset-1 time2">

## Nodes

</div>
<div class="col-3 offset-1 time3">

## Resources

</div>
</div>
</div>

!SLIDE slide5
<script>
audio("slide5")
timeline([8500,11000,26000,29000],"slide5")
</script>

# Navigation

<div style="position: relative">
<div style="position: absolute">

![Event inspector screenshot](_images/event_view.png)

</div>
<div style="position: absolute" class="time1">

![Event inspector screenshot highlighting detail pane](_images/event_detail.png)

</div>
<div style="position: absolute" class="time2">

![Event inspector screenshot highlighting context pane](_images/event_context.png)

</div>
<div style="position: absolute" class="time3" >

![Event inspector screenshot highlighting breadcrumb navigation](_images/event_breadcrumbs.png)

</div>
<div style="position: absolute" class="time4" >

![Event inspector screenshot highlighting back button](_images/event_back.png)

</div>
</div>
</div>
</div>

!SLIDE slide6 full
<script>
audio("slide6")
timeline([33000,34000,49000],"slide6")
</script>

# Drilling down
<div style="position: relative">
<div style="position: absolute">

![Event inspector summary_screenshot](_images/event_inspector_summary.png)

</div>
<div style="position: absolute" class="time1">

![Event inspector classes_with_failures_screenshot](_images/event_inspector_classes_with_failures.png)

</div>
<div style="position: absolute" class="time2">

![Event inspector nodes all_screenshot](_images/event_inspector_nodes_all.png)

</div>
<div style="position: absolute" class="time3">

![Event inspector classes_with_failures_screenshot](_images/event_inspector_classes_with_failures.png)

</div>
</div>
</div>
</div>

!SLIDE slide7
<script>
audio("slide7")
timeline([26000,30000,33000],"slide7")
</script>

# Perspectives

<div class="container">
<div class="row m-5 align-items-end">
<div class="col-3">

![Building blocks representing a class](_images/class.svg)

</div>
<div class="col-3 offset-1">

![A set of nodes](_images/servers.svg)

</div>
<div class="col-3 offset-1">

![Building blocks representing a resource](_images/resource.svg)

</div>
<div class="col-3">
<div class="row time2">

## What

</div>
<div class="row">

## (Classes)

</div>

</div>
<div class="col-3 offset-1">
<div class="row time1">

## Where

</div>
<div class="row">

## (Nodes)

</div>
</div>
<div class="col-3 offset-1">
<div class="row time3">

## How

</div>
<div class="row">

## (Resources)

</div>
</div>
</div>

!SLIDE[bg=_images/background.png] center inverse

## Thank you for taking Event Inspector
