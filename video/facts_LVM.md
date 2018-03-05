{% include '/version.md' %}

# Facts

In this lesson, I'll explore `facter`, a tool the Puppet agent uses to discover information
about the system where it's running. I'll demonstrate how to use the `facter` tool to access this
system information yourself, then show you how to incorporate facts into your Puppet code.

To help demonstrate facts directly, I'll take a detour in this lesson from the Pasture module
example used in the previous lessons and instead create a new Message of the Day or (MOTD) module,
using facts from the system to create a custom message to be displayed whenever a user connects
to my agent node.

Before getting started, I'll use the quest command to set up the environment for this lesson:

    quest begin facter

## Facter

In the agent run video, I briefly discussed facter's role in a Puppet run: the
Puppet agent runs `facter` to get a list
of facts about the system, which it then sends to the Puppet master as part of
its catalog request. The Puppet master then uses these facts to help compile a catalog
defining the desired state for the Puppet agent's node. Having access to this kind
of information as it's compiling the catalog means that Puppet can be very adaptable
across different nodes in your infrastructure. Depending on what operating system a node is running,
what timezone it's in, how much memory it has availalbe, and a whole range of other
facts, Puppet can compile a catalog as precisely tailored as you like.

Outside the context of catalog compilation, you can also use facter as a stand-alone
command-line tool to investigate a system yourself. Before I get into integrating
facts into Puppet code, exploring facter directly through the command-line is
a great way to get an idea of what kinds of facts are available and how they're structured.

<div class = "lvm-task-number"><p>Task 1:</p></div>

First, I'll connect to the agent node prepared for this lesson:

    ssh learning@pasture.puppet.vm

I can access a standard set of facts using the `facter` command. Adding the
`-p` flag will include any custom facts that I may have installed on the
Puppet master and synchronized with the agent during the pluginsync step of a
Puppet run. I'll pass this `facter -p` command to `less` so I can scroll
through the output in my terminal.
	
    facter -p | less

This quickly gives me an idea of the variety of facts available on this node.
When I'm done, I'll use `q` to quit `less`.

I can get the value of a specific fact, by passing in the name of that fact
as a command-line argument.

    facter -p os
    
Some facts, such as this `os` fact, include structured data, which is shown
here in a nested JSON format.

I can drill down into this structure by using dots (`.`) to specify the key
at each child level of tree, for example:

    facter -p os.family

Now that I know how to check what data are available via `facter` and how the
data are structured, I'll return to the Puppet master so I can show how this
can be integrated into my Puppet code. Remember, you can always refer to the
facter docs page or use the facter -p command yourself to further explore what facts
are available.

    exit

All the facts available through facter automatically made available within Puppet manifests. I can
access the value of any fact via the `$facts` variable, which is set for me
automatically in every manifest. The value of this variable is a data structure
called a hash, that lets me look up any fact by passing its name in square brackets
after the facts variable:

    $facts['fact_name']

To access structured facts within a manifest, I can chain more names together with
the same bracket indexing syntax. For example, the `os.family` fact I accessed
above is available within a manifest as `$facts['os']['family']`:

    $facts['os']['family']

Especially if you're looking at older Puppet code, you'll likely run across facts
called directly by name, rather than through the $facts variable. In fact, all top-level
facts are available directly 

As I mentioned above, I'm going to take a break from the Pasture module I've been working on
to create a new MOTD module. This MOTD file is commonly used on Linux systems to display
information about a host when a user logs in. Using facts will allow Puppet to manage
MOTD with custom information about the system.

Creating a new module will from scratch will also give me a chance to review some of the
concepts I've discussed in the previous lessons.

<div class = "lvm-task-number"><p>Task 2:</p></div>

From my `modules` directory, I'll create the directory structure for a module
called `motd`. Here, I'll need two subdirectories called `manifests` and
`templates`.

    mkdir -p motd/{manifests,templates}

<div class = "lvm-task-number"><p>Task 3:</p></div>

I'll begin by creating an `init.pp` manifest to contain the main `motd` class.

    vim motd/manifests/init.pp

This class will consist of a single `file` resource to manage the `/etc/motd`
file. I'll use an EPP template to set the value for this resource's `content`
parameter. To pass in values for this template, I'll set the value of an $motd_hash
variable using facts for all the values I want to show in the MOTD file.

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

With this template set, my simple MOTD module is complete. I'll open my
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

