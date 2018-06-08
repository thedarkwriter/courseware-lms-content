# Introduction

In this video, I'll walk through the steps involved in downloading and setting
up the Puppet Learning VM. 

The Learning VM is a free, interactive, self-contained learning environment
that gives you a way to learn and explore Puppet Enterprise without needing to
first set up your own Puppet master server and agent systems.

The "VM" in Learning VM stands for "virtual machine." A virtual machine is an
emulated computer system you can run on your own desktop or laptop through
virtualization software. Though a VM shares the host system's hardware, the
operating system and filesystem are completely distinct. While the Puppet agent
can be installed on a wide variety of devices and operating systems, the Puppet
server requires a Linux system. So vitualization gives you a convenient way to
get started learning Puppet from your own system, even if you're running
Windows or MacOS. 

In most cases, the setup process for the Learning VM goes smoothly. However,
the combined complexity of the virtualization software and the Puppet master
server can make it a little tricky to troubleshoot if you do run into problems.

I'll cover the system requirements, the Learning VM download, and recommended
virtualization software. Next, I'll go over process to import, configure, and
start up the Learning VM.

Note that some details of the setup process and may change after this video is
published. In this case, I'll update the notes below this video to address
those changes or direct you to more recent content.

## System requirements

Before beginning the setup process for the Learning VM, you should first check
that your system meets the minimum requirements.

The Learning VM runs a full Puppet Enterprise stack, which includes the Puppet
master, the PE console, PuppetDB, and several other supporting services. It
also runs local versions of several services needed to support a Puppet
development workflow, such as a local git server and a Forge module server.
Though we've made some tuning changes to the services running on the VM to
reduce their memory needs, the requirements are still significant. To run the
necessary services correctly will require sufficient memory available on your
host machine and allocated to the Learning VM through your virtualization
software.

You'll need:

10 GB of free disk space,
A 2 core 2.5 Gigahertz or greater CPU with a 64 bit architecture
Enabled hardware virtualization
3GB of free memory.

Note that the memory requirement refers to the amount of memory actually free
and available on your system when you're running the Learning VM. This will be
less than the amount of physical memory installed on your computer due to the
requirements of your operating system and any other processes running on your
system.

## Hardware Virtualization

Because the Learning VM is run with virtualization software, you'll also need
to check that your CPU supports virtualization, that its virtualization
options are enabled in the BIOS, and that another hypervisor such as Hyper-V
doesn't have an exclusive lock on your CPU's virtualization features.

Most modern processors have support for hardware virtualization with either
Intel VT-x or AMD-V.

Intel-based Macs released since 2010 support VT-x hardware virtualization and
this feature is enabled by default.

In Windows 8 and 10, you can check if virtualization is enabled through
the *Performance* tab of the Task Manager. If virtualization is not listed
here, your CPU does not support virtualization.

If it is listed, but shown as *Disabled*, your CPU does support hardware
virtualization, but the feature is disabled. Enabling virtualization is
generally simple, but it requires modifying your system's firmware settings
through a BIOS menu. The details of this process can vary from system to system
and may be restricted by your employer's IT policy. I suggest referring to your
IT department or looking online for documentation specific to your system.

On Windows systems, must ensure that Hyper-V, the Windows native hypervisor, is
disabled. Hyper-V takes an exclusive lock on your system's hardware
virtualization features, which prevents other virtualization software from
working correctly. You can turn Hyper-V off through the *Windows Features* or
*Programs and Features* pane. This is found listed under *Settings* in Windows
10, and *Control Panel* in Windows 8. You must reboot for the change to take
effect.

On Linux systems, you can use a command-line session to check the flags listed
in the `/proc/cpuinfo` file for `vmx` to incidate VT-x virtualization support
or `svm` to indicate AMD SVM virtualization support. If these flags are not
shown, it's possible that hardware virtualization is supported by the CPU, but
has been disabled in the BIOS. In this case, please refer to your IT department
or look online for documentation specific to your system.

## Get the VM

Once you've checked that your system meets the requirements, begin the Learning
VM download. I'll include a link to the download page in the notes below the
video. The Learning VM is upwards of three gigabytes—remember, you're
downloading an image of a full CentOS 7 system with Puppet Enterprise and
sevaral other services already installed and configured. Depending on your
network speed, the download can take anywhere from a few minutes to several
hours. If it looks like the download will take a long time, I suggest using a
download manager, which will allow you to pause or restart the download if
needed, and save you the frustration of having to start over if the download
is interrupted. If you don't already have a preferred download manager, an
online search can help you find a free or low-cost option compatible with your
operating system.

The download page includes a link to download the Learning VM archive, as
well as version information and an MD5 hash you can use to validate your
download when it completes. While the VM is downloading, you can continue on
to the next section for details on setting up your virtualization software.

## Virtualization software

To run the Learning VM, you'll need an up-to-date version of either VirtualBox
or VMware's Fusion, Workstation, or Workstation Player virtualization software.
Running the Learning VM on cloud virtualization platforms such as VMware
vSphere is untested and unsupported.

As [VirtualBox](https://www.virtualbox.org/wiki/Downloads) is free and
available for Linux, Mac, and Windows systems, I'll be using it here to walk
you through the setup process. Though the interface and menu options in VMware
virtualization software differ in their specifics, the overall steps involved
are parallel.

To download VirtualBox, go to the VirtualBox website and navigate to the
downloads page. From here, select the platform package. In this case, I'm
working on a Windows system, so I'll select the package for Windows hosts.
After completing the download, run the executable to install VirtualBox to your
system.

## Import appliance

Now that the virutalization software is installed, the next step is to extract
the downloaded Learning VM archive. The archive contains readme files and an
Open Virtual Appliance, or OVA package for the Learning VM itself.

To import the Learning VM, launch your virtualization software and select the
*Import* or *Import Appliance* option. Be sure to use *import* rather than *open*
or *new*, as these options are intended for different file formats. When
prompted, navigate to the Learning VM OVA file on your system where you
extracted it and select it. Accept the default import options. The import
process may take a minute or two to complete.

If you're using VMware software be sure to select *customize options* when the
import completes so you can make some changes before starting the VM. If you
start it up by mistake, wait for it to start completely before shutting it down
to change the settings.

## Networking configuration

You'll need to make some adjustments to VM's network settings before booting
the VM so its network service will start up with the correct configuration.

We recommend running the Learning VM with a host-only adapter on VirtualBox or
private virtual network on VMware software. This will connect the Learning VM
to your host machine through a virtual network adapter provided through the
virtualization software itself. This lets you connect to the Learning VM from
your host system without attaching to any outside network.

Restricting the Learning VM to the host-only network avoids potential security
exposure and prevents any issues that could be caused by proxies or firewall
rules disrupting communications between your host system and the Learning VM.

All the packages and modules needed to complete the lessons on the Learning VM
are hosted locally on the VM itself, and the tools and services on the Learning
VM are configured to use this local content.

If you complete the content on the Learning VM and want to experiment with
packages or modules not included in its lessons, you'll likely find it more
productive to install Puppet Enterprise on a new base image, and use a tool
like Vagrant to manage your test environment.

Before configuring the Learning VM to connect to a host-only network adapter,
you'll need to ensure that your virtualization software has this adapter set
up. VMware desktop virtualization software has a private virtual network
pre-configured by default. For VirtualBox, you may need to create this network
yourself, depending on the VirtualBox version and your operating system. Go to
the *Host Network Manager* pane from the *file* menu. If a network adapter
called vboxnet0 already exists and has not been modified, ensure that the DHCP
Server option is enabled. If no network adapter is listed, or you've modified
the existing adapter, create a new one. Ensure that the DHCP Server option is
enabled and leave the defaults unchanged for the other fields.

**IPv4 Address: 192.168.56.1**  
**IPv4 Network Mask: 255.255.255.0**  

**Server Address: 192.168.56.100**  
**Server Mask: 255.255.255.0**  
**Lower Address Bound: 192.168.56.101**  
**Upper Address Bound: 192.168.56.254**  

Now that this adapter is set up, you'll need to assign it to the Learning VM.
Select the Learning VM and open its settings pane. Go to the Network section,
and select *Host-only Adapter* from the dropdown menu, then select the name
of the host-only adapter you just configured or verified.

For VMware software, select the private network option listed under custom
network adapters.

## Log in

Once you've set up networking, boot up the VM. When the VM start up is
complete, you'll see a splash page showing the VM's IP address and login
credentials. You may notice that if you click on the console window, it
captures your cursor. The key combination to release the cursor is shown in the
corner of the console window.

Though you can interact with the VM via the console provided by your
virtualization software, this doesn't support features like copy and paste, and
the screen size is restricted. For a better experience, I suggest using the
Learning VM's built-in web-terminal or connecting via SSH.

To access the web terminal, open your web browser on your host system and
navigate to port 9091 at the VM's IP address. Be sure to use HTTP, rather than
HTTPS, as HTTPS is reserved for access to the Puppet Enterprise console.

    http://<VM's IP ADDRESS>:9091

While the web terminal is convenient, you might prefer connecting over SSH
through a terminal application.

On Mac systems, you can use the default Terminal application or a third-party
application like iTerm. For Windows, I suggest the free SSH client
[PuTTY](http://www.putty.org/). I'll post a link to PuTTy in the notes below
this video.

Use the credentials provided on the VM console splash page to authenticate via
SSH.

## Get started

Once the VM is set up and you've connected, you're ready to get started on the
interactive lessons in the Learning VM's Quest Guide. Access the Quest Guide by
opening a web browser on your host system and entering the Learning VM's IP
address in the address bar

    http://<IP-ADDRESS>

Again, be sure to use HTTP, as HTTPS is reserved for the PE console.

## Localization

The Learning VM's Quest Guide and Quest tool currently support English and
Japanese localization. The default language is English. If you would like to
use the Quest tool in Japanese, you can do this by changing the LANG
environment variable.

    export LANG=ja_JP.utf-8

Note that you must use SSH or the browser-based web terminal to see Japanese
characters. Japanese characters will not display correctly on the default
VirtualBox or VMware terminal.

## Conclusion

Now that you have the Learning VM set up, you have the option to continue along
with the video series or, follow along with the text version of the Learning
VM's Quest Guide, or refer to both. Whith some minor changes and adaptations,
the content in the videos is the same as that covered in the Quest Guide, and
the interactive tasks are identical.

I hope you find the Learning VM a useful way to get started with Puppet, and
that this video helped you get started. If you run into any issues setting up
the Learning VM or working through the content, feel free to get in touch at
the email address listed in the notes below and we'll be happy to help you out.
