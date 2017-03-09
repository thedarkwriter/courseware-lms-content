# Event Inspector
The Event Inspector, part of the Puppet Enterprise Console, is a reporting tool that provides data for investigating the current state of your infrastructure. Its focus is on correlating information and presenting it from multiple perspectives, in order to reveal common causes behind related events.

At the end of this course you will be able to:

* List the three perspectives you can use to view your infrastructure.
* Define an event.
* Explain the four types of events found in Event Inspector.

## Video Transcript

## Slide 0



## Slide 1

Puppet Enterprise (PE) event inspector is a reporting tool that provides data for investigating the current state of your infrastructure. Its focus is on correlating information and presenting it from multiple perspectives, in order to reveal common causes behind related events. Event inspector provides insight into how Puppet is managing configurations, and what is happening where when events occur.
Event inspector lets you accomplish two important tasks: monitoring a summary of your infrastructure’s activity and analyzing the details of important changes and failures. Event inspector lets you analyze events from several different perspectives, so you can reject noise and choose the context that best allows you to understand events that concern you.

## Slide 2

An “event” is PE’s attempt to modify an individual property of a given resource. During a Puppet run, Puppet compares the current state of each property on each resource to the desired state for that property. If Puppet successfully compares them and the property is already in sync (the current state is the desired state), Puppet moves on to the next without noting anything. Otherwise, it will attempt some action and record an event, which will appear in the report it sends to the puppet master at the end of the run. These reports provide the data event inspector presents.
There are four kinds of events, all of which are shown in event inspector:
  * Change: a property was out of sync, and Puppet had to make changes to reach the desired state.
  * Failure: a property was out of sync; Puppet tried to make changes, but was unsuccessful.
  * Noop: a property was out of sync, but Puppet was previously instructed to not make changes on this resource (via either the --noop command-line option, the noop setting, or the noop => true metaparameter). Instead of making changes, Puppet will log a noop event and report the changes it would have made.
  * Skip: a prerequisite for this resource was not met, so Puppet did not compare its current state to the desired state. (This prerequisite is either a failure in one of the resource’s dependencies or a timing limitation set with the schedule metaparameter.) The resource may be in sync or out of sync; Puppet doesn’t know yet.

## Slide 3

Perspectives
Event inspector can use three perspectives to correlate and contextualize information about events:
  * Classes
  * Nodes
  * Resources
For example, if you were concerned about a failed service, say Apache or MongoDB, you could start by looking into failed resources or classes. On the other hand, if you were experiencing a geographic outage, you might start by drilling into failed node events.
Switching between perspectives can help you find the common threads among a group of failures, and follow them to a root cause. One way to think about this is to see the node as where an event takes place, while a class shows what was changed and a resource shows how that change came about.

## Slide 4

The event inspector page displays two panes of data. Clicking an item will show its details (and any sub-items) in the detail pane on the right. The context pane on the left always shows the list of items from which the one in the right pane was chosen, to let you easily view similar items and compare their states.
To backtrack out of the current list of items, you can use the breadcrumb navigation or the in-page back button (appearing left of the left pane after you’ve clicked at least one item). Do not use your web browser’s back button; this can cause event inspector to reload and lose your place.

## Slide 5

When event inspector first loads, the left pane contains the summary view. This list is an overview of recent Puppet activity across your whole infrastructure, and can help you rapidly assess the magnitude of any issues.

The summary view is split into three sub-lists, with one for each perspective (classes, nodes, and resources). Each sub-list shows the number of events for that perspective, both as per-event-type counts and as bar graphs which measure against the total event count from that perspective. (For example, if four classes have events, and two of those classes have events that are failures, the “Clases with events” bar graph will be at 50%.)

You can click any item in the sub-lists (classes with failures, nodes with events, etc.) to load more specific info into the detail pane and begin looking for the causes of notable events. Until an item is selected, the right pane defaults to showing classes with failures.

## Slide 6

Once the summary view has brought a group of events to your attention, you can use event inspector to analyze their root causes. Event inspector groups events into types based on their role in Puppet’s configuration code. Instead of taking a node-centric perspective on a deployment, event inspector takes a more holistic approach by adding the class and resource views. One way to think about this is to see the node as where an event takes place, while a class shows what was changed and a resource shows how that change came about.

## Slide 7

Be sure to read through the Tips & Issues section of the Docs page. Link below.
Also, walk through the example `testweb` in the Analyzing Changes & Failures section of the Docs page. Link below.
http://docs.puppetlabs.com/pe/latest/console_event-inspector.html#analyzing-changes-and-failures

## Slide 8


## Exercises
There are no exercises for this course. However, you can download Puppet Enterprise for free and use it on up to 10 nodes to test the features of the Console. [Download PE](https://puppetlabs.com/puppet/puppet-enterprise)

## Quiz
1. **True** or False.  At its core, Event Inspector is a reporting tool available in the Puppet Enterprise Console.

2. There are four types of Events in Event Inspector. Which of the following is not an Event?
	a. Change
	b. Failure
	c. Noop
	d. **Apply**

3. Event Inspector offers three perspectives to look at your infrastructure. They are Classes, Nodes, and which of the following items?
	a. Modules
	b. Manifests
	c. **Resources**
	d. Events

4. True or **False**. It is advisable to use the *Back* button while navigating through Event Inspector.

5. True or **False**. WIth Event Inspector you can accomplish 142 *important* tasks.

## References
* [Event Inspector - Docs](http://docs.puppetlabs.com/pe/latest/console_event-inspector.html)
* [Event Inspector - Tips & Issues](http://docs.puppetlabs.com/pe/latest/console_event-inspector.html#tips--issues)
* [Event Inspector `testweb` Example](http://docs.puppetlabs.com/pe/latest/console_event-inspector.html#analyzing-changes-and-failures)
* [Event Inspector Overview - Joe Wagner](http://www.youtube.com/watch?v=ewuHStACRLI)
