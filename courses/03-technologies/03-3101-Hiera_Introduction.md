# An Introduction to Hiera
Hiera is a key/value lookup tool for configuration data, built to make Puppet better and let you set node-specific data without repeating yourself. Hiera support is built into Puppet 3, and is available as an add-on for Puppet 2.7.

At the end of this course you will be able to:

* describe the benefits of data separation with Hiera.
* explain a use case of Hiera and its basic configuration syntax.

## Video
[Link to Video](http://linktovideo)

## Exercises
Assuming you have a working Puppet installation:

1. Execute, etc.
2. Execute, etc.
3. Execute, etc.

## Quiz
1. True or False. Hiera is primarily useful in separating configuration data from your Puppet modules. (True)
2. Which of the following is not a benefit, as listed in the video?
	a. Hiera makes it easier to configure your own nodes.
	b. Hiera makes it easier to re-use public Puppet modules.
	c. **Hiera makes it easier to configure your Puppet Master during installation.**
	d. Hiera makes it easier to publish your own modules.
3. True or False. Hiera allows for PostgreSQL backends. (True)
4. When searching the data backends Hiera will:
	a. **begin with the first backend listed.**
	b. search all backends listed.
	c. randomly search the backends listed.
	d. traverse the listed backends from bottom up.
5. True or False. The Hiera configuration file must be a valid YAML hash file. (True)

## Resources
* [Hiera - Github](https://github.com/puppetlabs/hiera)
* [Hiera - Docs](http://docs.puppetlabs.com/hiera/1/)
* [Hiera - Project Page](http://projects.puppetlabs.com/projects/hiera)