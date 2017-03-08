# What is Puppet?
Puppet manages your infrastructure. You describe configurations in an easy-to-read declarative language, and Puppet will bring your systems into the desired state and keep them there.

At the end of this course you will be able to:

* explain what Puppet is and why it is used.

## Video ##
[What is Puppet? - Vimeo](https://vimeo.com/60768300)

## Transcript
"Let's say you're a social media company, or a bank, or you're in some other industry, and you have a lot of these: servers, workstations. We'll call them nodes."

"Your infrastructure is large and getting larger. And you are responsible for managing it. You have a problem. But there is a solution."

"You put Puppet on each of these nodes. And just like there was one ring to rule them all, there's a Puppet Master to manage all these nodes for you."

"Every thirty minutes, each node checks in with the Puppet master, and asks 'Do I look the way I'm supposed to look?' If the node looks the way it's supposed to, nothing happens. If the node doesn't look like it's supposed to, the Puppet master tells it what it should look like. And the node gets to work turning itself back to the way it's supposed to look."

"So what's really going on? Puppet let's you specify a desired state within your configuration. It's the way things 'should' look. And this is done in a language we can all understand. In fact, you probably do something like this every morning when you're getting dressed. Yes, you should have shoes on when you leave the house. When a node doesn't resemble the desired state, we say that 'drift' has occurred." 

"Here's how we know drift has occurred. Like we mentioned earlier, the node (or the Puppet agent) checks in with the Puppet master every thirty minutes. It does this by sending facts to the Puppet master. These facts are the data about the current state of the node. The Puppet master uses the facts to compile a catalog, which is detailed data about how the node should be configured, and sends it back to the node. The node enforces the changes to ensure it matches the desired state."

"After the changes are made, the Puppet agent sends a complete, report back to the Puppet master, which you can access later and even integrate with other systems."

"So, sit back, relax, have a cup of coffee, and let Puppet manage your infrastructure."

## Exercises
There are no exercises for this course.

## Quiz

1. By default, a Puppet Agent checks in with the Puppet Master every:
a. 10 minutes
b. **30 minutes**
c. 60 minutes
d. 120 minutes
2. True or False. Puppet lets you specify a *desired* state for your infrastructure. (True)
3. What is the term used to describe when a node does not match the desired state?
a. out-of-sync
b. failed state
c. **configuration drift**
d. node divergence
4. What does the node, or Puppet Agent, send to the Puppet Master when it checks in?
a. **facts**
b. resources
c. variables
d. manifests
5. True or False. The Puppet Agent compiles a report that it sends to the Puppet Master after each Puppet run. (True)

## References
* [Learning Puppet Series](http://docs.puppetlabs.com/learning/)
* [Learning Puppet VM](http://info.puppetlabs.com/download-learning-puppet-VM.html)