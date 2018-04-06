# Introduction

In this video, I'll walk through the steps involved in getting the Puppet
Learning VM set up on your system. 

The Learning VM provides a virtualized CentOS 7 system with Puppet Enterprise
pre-installed. While the Puppet agent can run on a wide variety of operating systems and
devices, the central Puppet master server requires Unix or Linux operating
system.

A virtual machine is a self-contained emulated computer system
you can run on your own desktop or laptop through virtualization software. The
Learning VM uses Docker containers to fully simulate the set of managed systems
needed to complete task in the included interactive tutorial content. This
combination of virtualization and containerization gives you a portable Puppet
learning environment that you can run on most modern systems.

In most cases, the setup process for the Learning VM goes smoothly. However,
the combined complexity of the virtualization software and the Puppet master
server can make it a little tricky to troubleshoot if you do run into problems.

To start, I'll cover the system requirements for the Learning VM, steps for
finding and installing virtualization software compatible with your system, and
how to download and validate the Learning VM archive.

Next, I'll go over the steps involved to import, configure, and start up the
Learning VM. This process is also described in the setup section of the README
file included with the Learning VM download.

Finally, I'll cover troubleshooting for some issues you may encounter during
the setup process, and as you work through the Learning VM's content. I'll
cover some common causes of Puppet run failures and possible issues with the
Learning VM's interactive task completion validation tools.

Note details of the setup process and troubleshooting may change after this
video is published. In this case, I'll update the notes below this video to
address those changes or direct you to more recent content.

## System requirements

Before beginning the setup process for the Learning VM, you should first check
that your system meets the minimum requirements.

The Learning VM runs a full Puppet Enterprise stack, which includes the Puppet
master, the PE console, PuppetDB, and several other supporting services. It
also runs local versions of several services needed to support a Puppet
development workflow, such as a local git server and a Forge module server.
Though we've made some tuning changes to the services running on the VM to
minimize their memory needs, the requirements are still significant. To run the
necessary services correctly will require sufficient memory available on your
host machine and allocated to the Learning VM through your virtualization
software.

You'll need:

10 GB of free disk space,
A 2 core 2.5 Gigahertz or better CPU with a 64 bit architecture and enabled hardware virtualization
3GB of free memory.

Note that the memory requirement refers to the amount of memory actually free
and available on your system when you're running the Learning VM. This will be
less than the amount of physical memory installed on your computer due to the
requirements of your operating system and any other processes running on your
system.

Because the Learning VM is run with virtualization software, you'll also need
to check that your CPU supports virtualization, that its virtualization
options are enabled in the BIOS, and that another hypervisor such as Hyper-V
doesn't have an exclusive lock on your CPU's virtualization features.

Most modern processors have support for hardware virtualization with either
Intel VT-x or AMD-V.

Intel-based Macs released since 2010 support VT-x hardware virtualization and
this feature is enabled by default. You can validate that it is supported with
the `systclt` command:

    `sysctl -a | grep machdep.cpu.features`

Check the output of this command for the VMX flag.

You can also use this command to verify that virtualization is enabled:

    `systclt -a | grep kern.hv_support`

The value shown should be 1 to indicate that virtualization is supported.

In Windows 8 and 10, you can easily check if virtualization is enabled through
the *Performance* tab of the Task Manager. If virtualization is not listed
here, your CPU does not support virtualization. If it is listed, but shows
*Disabled*, your CPU does support hardware virtualization, but the feature is
disabled. Enabling virtualization is generally simple, but it requires
modifying your system's firmware settings through a BIOS menu accessible as
your system boots. The details of this process can vary from system to system
and may be restricted by your employer's security policy. I suggest referring
to your IT department or looking online for specific documentation.

On Windows systems, you will also need to ensure that Hyper-V, the Windows
native hypervisor, is disabled. When Hyper-V is enabled, it takes an
exclusive lock on your system's hardware virtualization features, which
prevents other virtualization software from working correctly. You can turn
Hyper-V on or off through the *Windows Features* or *Programs and Features*
pane. This is found listed under *Settings* in Windows 10, and *Control Panel*
in Windows 8. You will have to reboot the computer for the change to take
effect.

On Linux systems, check the flags listed in the `/proc/cpuinfo` file for
`vmx` to incidate VT-x virtualization support or `svm` to indicate AMD SVM
virtualization support. If these flags are not shown, it's possible that
hardware virtualization is supported by the CPU, but has been disabled in the
BIOS. Please refer to your IT department or look online for specific
documentation for enabling virtualization options in the BIOS.

## Get the VM

Once you've verified that your system meets the requirements,
start the Learning VM download. There is a link
to the download page in the notes below the video. The Learning VM is upwards
of three gigabytes, so depending on your network speed, the download can be
quite slow. You may want to consider using a download manager, which will allow
you to pause or restart the download if needed. I'll include links to some free
download managers in the notes.

From the Learning VM page at puppet.com, enter your email address before
continuing on to the download page. 

The download page includes a direct link to the Learning VM archive, as
well as version information and an MD5 hash you can use to validate your
download. Once you get this download started, you can move on to the next steps
as it completes.

## Virtualization software

To run the Learning VM, you'll need an up-to-date version of VirtualBox or
VMware's Fusion, Workstation, or Workstation Player virtualization software.

As [VirtualBox](https://www.virtualbox.org/wiki/Downloads) is free and
available for Linux, Mac, and Windows systems, I'll be using it here to walk you
through the setup process. Though the interface and menu options in VMware
virtualization software differ, the overall steps involved are parallel.

To download VirtualBox, go to the VirtualBox website and navigate to the
downloads page. From here, select the platform package for Windows hosts.
After completing the download, use the executable to start VirtualBox.

Before importing the Learning VM, validate the MD5 checksum for the
download with the File Checksum Integrity Verifier utility through the command
prompt.

    FCIV -md5 c:\path\to\download

By comparing the output of this command to the MD5 sum shown on the website, I
can validate that the file was downloaded correctly.

The commands to validate this checksum on MacOS and Linux systems are `md5` and
`md5sum` respectively.

    md5 /path/to/file

    md5sum /path/to/file

Next, unzip the archive.

The archive contains readme files and an Open Virtual Appliance, or OVA package
for the Learning VM itself.

Import this OVA package to load the Learning VM. Note that if you're
using VMware virtualization software, you may also see options to create a new
VM or open a VM. Because the Learning VM is in the OVA format, be sure to use
an **Import** or **Import Appliance** option. If you cannot locate this option,
refer to your virtualiation software's documentation for instructions on
importing an OVA.

When prompted, accept the default options for the import.

Before launching the VM, you need to make a few adjustments to the network
settings.

## Networking configuration

All the packages and modules needed to complete the Quest Guide are hosted
locally on the VM itself, meaning that all the content in the Learning VM
can be completed without internet access. However, you'll need to make some
adjustments to the VM's network configuration to ensure that you can access
the VM from your host system.

As your local network may have proxies, a firewall, or other settings that can
potentially disrupt communications among the services on the Learning VM,
you'll get the most consistent experience running the VM with a host-only
network adapter. A host-only network is a virtual network provided by the
virtualization software itself and accessible only through your host system and
and Virtual Machines assigned to the network. The cost of this consitency is a
few extra steps to set up this host-only network.

For **VirtualBox:**

To use host-only networking on VirtualBox, you will need to create and
configure a new network from the VirtualBox *preferences* panel. Note that this
may be called *settings* on some systems. Be sure that you're looking at the
preferences for VirtualBox itself, not the settings configurations for a
specific VM.

Open the VirtualBox preferences panel and select the **network** section.
Select **Host-only Networks**. Create a new network, and click the screwdriver
icon to the side of the dialog to edit the network configuration. In the
**Adapter** section, enter the following settings:  

**IPv4 Address: 192.168.56.1**  
**IPv4 Network Mask: 255.255.255.0**  

In the **DHCP Server** section, enter the following settings:

Check the **Enable Server** box  
**Server Address: 192.168.56.1**  
**Server Mask: 255.255.255.0**  
**Lower Address Bound: 192.168.56.110**  
**Upper Address Bound: 192.168.56.200**  

Click **OK** to accept the adapter configuration changes, and again to exit the
preferences dialog. Open the settings section for the Learning VM from the
VirtualBox Manager window. Go to the **Network** section, select **Host-only
Adapter** from the drop-down menu, and select the name of the host-only adapter
you created from the **Name:** drop-down. Click **OK** to accept the setting
change.

VMware software comes with this host-only network already configured. In this
case, you can skip the network creation step and assign the VM to private
network adapter in the network section of the VM settings pane.

### Online

If you would like to run the Learning VM with internet access, set the
*Network Adapter* to *Bridged*. Use an *Autodetect* setting if available, or
accept the default Network Adapter name. (If you started the VM before making
these changes, you may need to restart the VM before the settings will be
applied correctly.)

Note that the Puppet module tool, yum, and RubyGems are configured to use local
repositories, so you will not be able to access remote content without manually
changing the settings for these tools. While we encourage exploration if you're
already comfortable re-configuring these, understand that you'll be going
outside the scope of what we've documented and can support.

## Log in

Start the VM. Rather than logging in directly, we suggest using the
browser-based web terminal or SSH.

To access the web terminal, open your web browser and navigate to
`http://<VM's IP ADDRESS>:9091`. Follow the instructions show on the
splash page to log in.

On Mac systems, you can use the default Terminal application or a third-party
application like iTerm. For Windows, we suggest the free SSH client
[PuTTY](http://www.putty.org/). Use the credentials provided on the VM console
splash page to authenticate.

Once you're logged in, continue on to the **Get started** section below to
access the Quest Guide and begin the interactive lessons.

## Localization

The Learning VM's Quest Guide and Quest tool currently support English and
Japanese localization. The default language is English. If you would like to
use the Quest tool in Japanese, run the following command on the Learning VM:
`export LANG=ja_JP.utf-8`. Note that you must use SSH or the browser-based web
terminal to see Japanese characters. Japanese characters will not display
correctly on the default VirtualBox or VMware terminal.

## Get started

Once the VM is set up and you have connected, you're ready to get started on
the interactive lessons in the Quest Guide. Access the Quest Guide by opening a
web browser on your host system and entering the Learning VM's IP address in
the address bar: `http://<IP-ADDRESS>`. (Note that you must use `http`, as 
`https` will connect you to the PE console interface.)
