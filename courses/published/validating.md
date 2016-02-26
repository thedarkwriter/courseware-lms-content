# Testing Puppet: Validating your code
In this course we look at the first level of testing, validating your Puppet code, using the Puppet Language Style Guide, Puppet parser, and puppet lint.

At the end of this course you will be able to:

*   Access the Puppet Language Style Guide.
*   Use Puppet parser to validate Puppet code syntax.
*   Install puppet-lint.
*   Use puppet-lint to compare your manifests to established coding standards.

## Exercise

1. Run Puppet Parser on the sample manifest file.

<pre>puppet parser validate /etc/puppetlabs/code/modules/ntplint/manifests/init.pp
</pre>

Puppet will return the following error message:  

<pre>Error: Could not parse for environment production: Syntax error at '{' at /etc/puppetlabs/code/
modules/ntplint/manifests/init.pp:3:68
</pre>

2. Edit the manifest to correct the issue.

<pre>vim /etc/puppetlabs/code/modules/ntplint/manifests/init.pp
</pre>

3. Run Puppet Parser again. Edit the file to correct the following error. And the run Puppet Parser once again to confirm that the code compiles.

<pre>Error: Could not parse for environment production: Syntax error at 'ntp' at /etc/puppetlabs/code/modules/ntplint/manifests/init.pp:47:21
</pre>

4. Run Puppet Lint on the sample manifest file.

<pre>puppet-lint /etc/puppetlabs/code/modules/ntplint/manifests/init.pp
</pre>

Puppet-lint will return the following list of warnings:

<pre>WARNING:top-scope variable being used without an explicit namespace on line 5 
WARNING:double quoted string containing no variables on line 10 
WARNING:string containing only a variable on line 39 WARNING: unquoted resource title on line 38WARNING:ensure found on line but it's not the first attribute on line 40
</pre>

5. Edit the manifest to correct these issues:

<pre>vim /etc/puppetlabs/puppet/modules/ntplint/manifests/init.pp
</pre>

6. Run puppet-lint again to see the result:

<pre>puppet-lint /etc/puppetlabs/puppet/modules/ntplint/manifests/init.pp
</pre>

7. Continue editing and checking until there are no remaining warnings.


## Quiz
1. Why should you use the Puppet module tool to create your Puppet modules?
a. It is too difficult to create modules manually.
(b). The Puppet module tools creates a basic module structure for you, including your spec and tests directories.
c. There is no other way to create the tests and spec sub-directories.
d. If you do not use the Puppet module tool to create your modules, you can not run test against them.

2. What is the purpose of the Puppet Language Style Guide?
a. The primary purpose of the Puppet language Style Guide is to stunt the creativity of developers.
b. The Puppet Language Style Guide protects you from making errors in your code and modules.
c. You must use the Puppet Language Style Guide if you want to submit your Puppet modules to the Puppet Forge.
(d.) The Puppet language Style Guide promotes consistent module formatting across Puppet Labs and the Puppet community.

3. Which of the following is a Puppet code guiding principle?
a. Create modules with a "use once and discard" mentality.
b. Be not concerned with readability.
c. Never veer from the Puppet Language Style Guide recommendations.
d. Scoping and simplicity are key.

4. What is the function of Puppet parser?
a. Puppet parser checks your code for deviations from the recommended coding styles and formats.
b. Puppet parser automatically builds the initial structure for your manifests.
(c.) Puppet parser validates Puppet DSL syntax without compiling a catalog or syncing any resources.
d. Puppet parser confirms the validity of the logic of your modules.

5. (True) or False. You can use puppet-lint to find and fix deviations from the Puppet Language Style Guide in your manifests.
