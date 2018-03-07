# PS consultant analysis and objectives
> What does a PS consultant need to know BEFORE starting any Discovery-related enablement? (Adjacent technologies? Concepts? Workflows?)

The consultant should have an understanding of the architecture and deployment of Discovery. That includes its agent-less model (internally known as "foraging" , publicly referred to as "discovery" ). They should be familar with the capabilities and limitations of this foraging process. This includes ["cloud provider"](cloud-providers) support such as services like Amazon Web Services (AWS) and SSH based node support. They should be aware of the capabilities and limitations of the underlying tools used to forage this data such as:

1. Troubleshooting SSH communication (Authentication and Authorization as well enabling on the target O.S. )
2. Troubleshooting WinRM communication (Authentication and Authorization as well enabling on the target O.S.) 
3. Configuring Cloud API Access (Authentication and Authorization as well creating the "secret" or api keys with the necessary privileges ) 
4. Troubleshooting errors in the Open Source projects that discovery relys on to gather data
  + [lumogon](https://lumogon.com/)
  + PDRP (precursor to libral)
  + [Facter](https://docs.puppet.com/facter/)
  + [Bolt](https://puppet.com/docs/bolt/0.x/bolt.html) 

[cloud-providers]: https://tickets.puppetlabs.com/browse/DI-1122

A general understanding of Docker (to understand the data coming back from lumogon ) is anticipated as well. Further as Docker and docker-compose will be the delivery mechanism for discovery, the consultant should have a general understanding of those technologies.

What should a PS consultant be able to do AFTER completing Discovery enablement?

1. Install an on premise solution Discovery. Assist the customer with adding nodes/containers known as "Discovery Units".
2. Troubleshoot missing Discovery Units of missing data on given unit. E.g. facter or lumogon not retrieving information the customer is interested in.

How do we assess the user's comprehension? What skills or knowledge are they being assessed on?

Quizzes that focus on discoveries limitations and capabilities are likely best. Example questions:

1. What cloud providers does Puppet Discovery support.
2. What data can Puppet Discovery extract about a Docker container (choose all that apply).
3. What needs to be enabled on Windows for Puppet Discovery to forage/discover data.


What is in scope and out of scope for learning this topic?

We likely don't need the consultant to understand everything about Docker. In much the same way we don't expect the consultant to understand the underlying technology they are automating with Puppet. This essentially means that a customer must provide a subject matter expert for what data they wish to extract and view using discovery.

# Reference links 

[Puppet Discovery 1.0 Messaging](https://confluence.puppetlabs.com/display/ProductMarketing/Puppet+Discovery+1.0+Messaging)  
[Discovery GA Marketing plan](https://docs.google.com/document/d/1enOWm2pviOVIX-ub5wLCw6wIRp0ANzmGtV9uGhuczGU/edit?ts=5a8c4314)  
[Discovery Component Characterization](https://docs.google.com/document/d/14mA22JLp1rjS2FoI2pr8shfRkS1Tx2nVdngh3aKXDNs/edit)  
[Discovery Messaging Brief](https://docs.google.com/document/d/1eWKtdKVahyQ46QeZii2QYaFdkJfoIdCdIwBd4uPttmk/edit)  
[Discovery GA Requirements](https://confluence.puppetlabs.com/display/DI/Puppet+Discovery+GA+Requirements)  
[Discovery Version proposal](https://docs.google.com/document/d/1XMoElNL3eoSvH1vLuZAIguY8vvJqzhtCO-DhN70ZfAY/edit)  
[Puppetconf Talk](https://www.youtube.com/watch?v=6_T53JmzVBU)  
[Discovery Nightly Builds](https://confluence.puppetlabs.com/display/DI/Puppet+Discovery+Home)  
[Discovery Sample Licence](https://github.com/puppetlabs/cloud-discovery/blob/master/workstation/internal/pkg/license/sample-license.json)  
[Discovery Slice Environment](https://pdlatest.slice.puppetlabs.net:8443/)  

> Password: `admin`
> This instance will be updated to master on a daily basis so there is potential for breakage.

