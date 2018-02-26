{% include '/version.md' %}

# Facts

In this lesson, I will explore `facter`, a tool that 
allows Puppet to automatically access information about the system where an agent is running
as variables within a Puppet manifest. I'll demonstrate how to use the `facter` tool to access that system 
information, and I'll show how to use the `facts` hash to incorporate system information into Puppet code. 

The class parameters I showed in the previous quest reduced
many of the tasks involved in configuring an application to a single, well-defined interface. 
I can make life even easier by writing a module that will automatically use
available system data to set some of its variables.

## Getting started

As I'll show in this lesson, facts can be quite useful on their own. In
the next lesson, I will show how they can be used along with *conditional
statements* to write Puppet code that will behave differently in
different contexts.

## Facter

We already encountered the `facter` tool when we ran `facter
ipaddress` in the first video. We briefly discussed
the tool's role in a Puppet run: the Puppet agent runs `facter` to get a list
of facts about the system to send to the Puppet master as it requests a
catalog. The Puppet master then uses these facts to help compile that catalog
before sending it back to the Puppet agent to be applied.

Before we get into integrating facts into Puppet code, let's use the
`facter` tool from the command line to see what kinds of facts are available
and how they're structured.

<div class = "lvm-task-number"><p>Task 1:</p></div>

First, I'll connect to the agent node prepared for this lesson:

    ssh learning@pasture.puppet.vm

I can access a standard set of facts using the `facter` command. Adding the
`-p` flag will include any custom facts that I may have installed on the
Puppet master and synchronized with the agent during the pluginsync step of a
Puppet run. I'll pass this `facter -p` command to `less` and scroll
through the output in my terminal.
	
    facter -p | less

When I'm done, I press `q` to quit `less`.

The output of this command is shown as a hash. Some facts, such as
`os`, include data in a nested JSON format.

    facter -p os

I can drill down into this structure by using dots (`.`) to specify the key
at each child level of the hash, for example:

    facter -p os.family

Now that I know how to check what data are available via `facter` and how the
data are structured, I'll return to the Puppet master so I can show how this
can be integrated into my Puppet code.

    exit

All facts are automatically made available within manifests. I can
access the value of any fact via the `$facts` hash, following the
`$facts['fact_name']` syntax. To access structured facts, I can chain more
names using the same bracket indexing syntax. For example, the `os.family` fact
I accessed above is available within a manifest as `$facts['os']['family']`.

I'm going to take a break from the Pasture module I've been working on. Instead,
I'll create a new module to manage an MOTD (Message of the Day) file. This
file is commonly used on \*nix systems to display information about a host when
a user connects. Using facts will allow me to create a dynamic MOTD that can
display some basic information about the system.

Creating a new module will also help review some of the concepts I've shown you so far.

<div class = "lvm-task-number"><p>Task 2:</p></div>

From my `modules` directory, create the directory structure for a module
called `motd`. I'll need two subdirectories called `manifests` and
`templates`.

    mkdir -p motd/{manifests,templates}

<div class = "lvm-task-number"><p>Task 3:</p></div>

Begin by creating an `init.pp` manifest to contain the main `motd` class.

    vim motd/manifests/init.pp

This class will consist of a single `file` resource to manage the `/etc/motd`
file. I'll use a template to set the value for this resource's `content`
parameter.

```puppet
class motd {

  $motd_hash = {
    'fqdn'       => $facts['networking']['fqdn'],
    'os_family'  => $facts['os']['family'],
    'os_name'    => $facts['os']['name'],
    'os_release' => $facts['os']['release']['full'],
  }

  file { '/etc/motd':
    content => epp('motd/motd.epp', $motd_hash),
  }

}
```

The `$facts` hash and top-level (unstructured) facts are automatically loaded
as variables into any template. To improve readibility and reliability, I
strongly suggest using the method shown here. Be aware, however, that
you will likely encounter templates that refer directly to facts using the
general variable syntax rather than the `$facts` hash syntax I suggest here.

<div class = "lvm-task-number"><p>Task 4:</p></div>

Now I'll create the `motd.epp` template.

    vim motd/templates/motd.epp

I begin with a parameters tag to make the set of variables used in the template
explicit. Since the MOTD is a plaintext file without any commenting syntax,
I'll leave out the conventional "managed by Puppet" note.

```
<%- | $fqdn,
      $os_family,
      $os_name,
      $os_release,
| -%>
```

Next, I add a simple welcome message and use the variables assigned from my fact
values to provide some basic information about the system.

```
<%- | $fqdn,
      $os_family,
      $os_name,
      $os_release,
| -%>
Welcome to <%= $fqdn %>

This is a <%= $os_family %> system running <%= $os_name %> <%= $os_release %>

```

<div class = "lvm-task-number"><p>Task 5:</p></div>

With this template set, my simple MOTD module is complete. I open my
`site.pp` manifest to assign it to the `pasture.puppet.vm` node. 

    vim /etc/puppetlabs/code/environments/production/manifests/site.pp

I'm not using any parameters, so I'll use the `include` function to add the
`motd` class to the `pasture.puppet.vm` node definition.

```puppet
node 'pasture.puppet.vm' {
  include motd
  class { 'pasture':
    default_character => 'cow',
  }
}
```

<div class = "lvm-task-number"><p>Task 6:</p></div>

Once this is complete, I connect again to the `pasture.puppet.vm` node.

    ssh learning@pasture.puppet.vm

And trigger a Puppet agent run.

    sudo puppet agent -t

To see the MOTD, I need to first disconnect from `pasture.puppet.vm`.

    exit

Now I'll reconnect.

    ssh learning@pasture.puppet.vm

I've had a chance to admire my MOTD, and now I'll return to the Puppet master.

    exit

## Review

In this quest, I introduced the `facter` tool and provided an overview of how
this tool can be used to access a structured set of system data.

I then showed how to access facts from within a Puppet manifest and assign
the values of these facts to variables. Using data from Facter, I created a
template to manage a MOTD file.

In the next lesson, I'll show how to add further flexibility to
Puppet code with *conditional statements*. I'll give you an example of how
these facts can be used in conjunction with these conditional statements to
create intelligent defaults based on system information.

