# Puppet Discovery enablement workshop

## Workshop Requirements
Download the (macOS) [Docker Community Edition](https://www.docker.com/community-edition)  

In this recorded workshop, Puppet professional services engineer Zack Smith walks through a workshop to get familair with Discovery and support engineer Adam Bottchen provides insight on troubleshooting Puppet Discovery. Follow the workshop details below so you can run through the lab on your system.

<div class="wistia_responsive_padding" style="padding:56.32% 0 0 0;position:relative;"><div class="wistia_responsive_wrapper" style="height:100%;left:0;position:absolute;top:0;width:100%;"><iframe src="https://fast.wistia.net/embed/iframe/aab5naz1m9?seo=false&videoFoam=true" title="Wistia video player" allowtransparency="true" frameborder="0" scrolling="no" class="wistia_embed" name="wistia_embed" allowfullscreen mozallowfullscreen webkitallowfullscreen oallowfullscreen msallowfullscreen width="100%" height="100%"></iframe></div></div>



### Part 1: Installing Discovery in Demo mode.

1. Ensure that the Docker engine is running on the target machine (mac).
2. Download the [`puppet-discovery`](https://storage.googleapis.com/chvwcgv0lwrpc2nvdmvyes1jbgkk/production/latest/darwin-amd64/puppet-discovery) binary for macOS

```shell
curl https://storage.googleapis.com/chvwcgv0lwrpc2nvdmvyes1jbgkk/production/latest/darwin-amd64/puppet-discovery -O
```

3.  Make it executable 

```shell
chmod +x ./puppet-discovery
```

4.  Run puppet discovery in Demo mode.

```shell
./puppet-discovery demo
```

5. Login to the Discovery console with the password `@Puppet`
 + [https://localhost:8443](https://localhost:8443) should open up automatically
+ Refresh the page if you get a "Bad Gateway" Error.

#### Troubleshooting

1. Verify the services/containers are running with `docker ps` and `./puppet-discovery status`


> [https://localhost:8443](https://localhost:8443) should open up automatically

2. Login in the Discovery console with the password `@Puppet`

### Part 2: Forging a node

1. Start a terminal window to view the discovery logs

```shell
docker logs -f pd_edge
```
2. Disable your local ssh deamon

```shell
sudo systemsetup -setremotelogin off
```
> This enables ssh debuging on localhost via port 22 of your host machine to work around [DI-2515](https://tickets.puppetlabs.com/browse/DI-2515)

3. In another window pull a new docker image

```shell
docker pull jdeathe/centos-ssh
```

4. In that same window run the container

```shell
docker run --name discovery_workshop --network=pd_net -p 22:22 jdeathe/centos-ssh:centos-7
```
> This command connects to the Puppet Discovery Networks



> Note: `sudo` is required for vagrant to be able to run on port 22

5. Download vagrant private key [here](https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant)
  + In yet another terminal window type the following:
```shell
curl https://raw.githubusercontent.com/hashicorp/vagrant/master/keys/vagrant -o /tmp/vagrant_key
```

6. Add the vagrant ssh private key file [here](https://localhost:8443/secrets/add-ssh-key)
 + Choose __Add keys__ and select the `/tmp/vagrant_key`
 + Fill the username as `app-admin` and leave password field blank
 + Choose __Discovery__ as the scope

 
7. Add the conatiner ip address via a CSV file [here](https://localhost:8443/sources/add-IP%20addresses)
  + Generate a [CSV](https://en.wikipedia.org/wiki/Comma-separated_values) file using the following command.
  
```shell
docker inspect $(docker ps | awk '/discovery_workshop/{print $1}') | \
  grep -oE '\d+\.\d+\.\d+\.\d+' | \
  tr [:space:] ',' >/tmp/discovery_hosts.csv
```


8. Login to [https://localhost:8443](https://localhost:8443) (Password __`@Puppet`__ )
  + Navigate to `Act` -> `Add Sources`
  + Click on `IP Addresses`
  + Choose "CSV" from `Type` drop down list
  + Choose the file `/tmp/discovery_hosts.csv`
  + Type "workshop_csv" in the name field.

> TIP: On macOS in the choose file dialog , you can use the keyboard combination _command ([&#8984;])"_ + _"shift"_ + _"g"_ and the type the path e.g. `/tmp` in the "Go to folder" drop down. 

9. Verify your host was added [here](https://localhost:8443/list/all-hosts)

### Part 3: Diagnosing a task failure 
1. Add the vagrant ssh private key file [here](https://localhost:8443/secrets/add-ssh-key)
 + Choose __Add keys__ and select the `/tmp/vagrant_key`
 + Fill the username as `app-admin` and leave password field blank
 + Choose __Tasks__ as the scope

> Note: This is a different username the used for discovery.

2. Copy the vagrant private key into the container for the `root` user

```shell
docker exec -it discovery_workshop mkdir /root/.ssh
docker cp /tmp/vagrant_key discovery_workshop:/root/.ssh/authorized_keys
```

3. Run the PE installation task [here](https://localhost:8443/add-task/select-task)
 + Choose __Install Puppet Agent on Linux__ from the drop down.
 + Fill the master as `classroom.puppet.com` and leave the rest of the fields blank and click __Select Hosts__
 + Select the node you previous forged in the list presented and click __Select Credentials__
 + Select the ssh private key you added in Step 1 and click __Review task summary__
 + Verify the task summary is correct and click __Run Task__
 + View the logs with GUI or `docker logs -f pd_edge` and determine the reason for the failure.

__You can find the answer [here](https://gist.github.com/acidprime/c2e7c19bf9283334c2e238a8574556bd)__

> TIP: Refer to the [Support Troubleshooting Doc](https://confluence.puppetlabs.com/display/SUP/Troubleshooting)

## Extra Credit 1: Resetting the installation

### Soft Reset

If you still have the administrator password you can reset the current discovery installation using:

```shell
./puppet-discovery reset
```


### Hard Reset

If you have forgotton the administrator password you can reset the docker files

```shell
rm -rf ./.puppet-discovery/
# WARNING: This deletes all running containers
# use docker ps if you use docker for something else.
docker rm -f $(docker ps -a -q)
docker volume rm pd_data_pdp_resources
docker volume rm pd_data_pdp_schemas
docker volume rm pd_data_vault_file
docker volume rm pd_data_vault_logs
```

> Then run the "soft reset command above"

## Internal Resources

These require access to internal Puppet Resources only avaiable to employees.

[Sample Licence](https://github.com/puppetlabs/cloud-discovery/blob/master/workstation/internal/pkg/license/sample-license.json)  
[Support Getting Started Doc](https://confluence.puppetlabs.com/display/SUP/Getting+Started+Walkthrough)  
[Support Troubleshooting Doc](https://confluence.puppetlabs.com/display/SUP/Troubleshooting)  
[Support Potential Customer Issues Doc](https://confluence.puppetlabs.com/display/SUP/Troubleshooting+Potential+Customer+Issues)  
[(Pre)Documentation](https://docs-preview.webteam.puppet.com/docs/discovery/ga/pd_introduction.html)  
[Puppet Discovery 1.0 Messaging](https://confluence.puppetlabs.com/display/ProductMarketing/Puppet+Discovery+1.0+Messaging)  
[GA Marketing plan](https://docs.google.com/document/d/1enOWm2pviOVIX-ub5wLCw6wIRp0ANzmGtV9uGhuczGU/edit?ts=5a8c4314)  
[Discovery Component Characterization](https://docs.google.com/document/d/14mA22JLp1rjS2FoI2pr8shfRkS1Tx2nVdngh3aKXDNs/edit)  
[Messaging Brief](https://docs.google.com/document/d/1eWKtdKVahyQ46QeZii2QYaFdkJfoIdCdIwBd4uPttmk/edit)  
[GA Requirements](https://confluence.puppetlabs.com/display/DI/Puppet+Discovery+GA+Requirements)  
[Version proposal](https://docs.google.com/document/d/1XMoElNL3eoSvH1vLuZAIguY8vvJqzhtCO-DhN70ZfAY/edit)  
[Nightly Builds](https://confluence.puppetlabs.com/display/DI/Puppet+Discovery+Home)  
[System Requirements](https://docs.google.com/document/d/160fkUblzLmzg1YmGpWSAfnGboOZzrH96pGs2uJKrPos/edit)  
[Slice Environment](https://pdlatest.slice.puppetlabs.net:8443/)  

## External Resources

[Workshop Slide Deck](https://docs.google.com/presentation/d/1tCeaKFgOvWtKwcZ4k644OINt_myyysv5udrFArV_HfA/edit?usp=sharing)  
[Documentation](https://puppet.com/docs/discovery/preview/introducing_discovery.html)  
[Puppetconf Talk](https://www.youtube.com/watch?v=6_T53JmzVBU)  



## Platform Installers
| Platform        | Link           | Notes  |
| ------------- |:-------------:| -----:|
| Mac     | https://storage.googleapis.com/chvwcgv0lwrpc2nvdmvyes1jbgkk/production/latest/darwin-amd64/puppet-discovery |  |
| Linux   | https://storage.googleapis.com/chvwcgv0lwrpc2nvdmvyes1jbgkk/production/latest/linux-amd64/puppet-discovery      |    |
| Windows | https://storage.googleapis.com/chvwcgv0lwrpc2nvdmvyes1jbgkk/production/latest/windows-amd64/puppet-discovery.exe      |  |

> Note: The puppet-discovery binary will not initially have execute permissions, so add them with `chmod +x ./puppet-discovery` if you are doing this on Linux or MacOS.

