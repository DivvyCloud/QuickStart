# DivvyCloud Quick Start using Docker Compose 

The fastest and most consistent way to launch DivvyCloud is to use Docker
Compose. This quick start guide provides instructions on how to use Docker
Compose to launch DivvyCloud and all of its service dependencies as containers
in less than 15 minutes.

This quickstart method is intended for trial environments, not production
environments. If you wish to set up a production environment, please refer
to our enterprise set-up documentation.

## Running DivvyCloud locally

### Install Docker MacOs

Instructions for installing on macOS and windows can be found [in the Docker Installation Guide](https://docs.docker.com/docker-for-mac/install/).

NOTE: `docker-compose` in automatically included with their application.

In the remaining documentation you will see `docker-compose` invoked with its full path.
this can be simplified on macOS by only using the command name.

```bash
# from
sudo -E /usr/local/bin/docker-compose up
# to
docker-compose up
```

## Provision DivvyCloud Instance

DivvyCloud supports two primary Linux distributions. They are:

 - Ubuntu 14.04+ 
 - CentOS 6+ (see note at end of instructions)

DivvyCloud requires an instance with at least:

 - 4 cores
 - 6 Gb of memory
 - 20 Gb root volume

If using AWS, we recommend using a m4.xlarge instance, which has 4 cores and 
16 Gb, and attaching a volume with 30 Gb.

## Install Docker and Docker-Compose

First, you need to install Docker 2.2 and Docker-Compose to use 
them for your installation. (For more information about Docker-Compose, 
please see https://docs.docker.com/compose/install/)

After logging into your DivvyCloud instance, run the following commands to
install Docker and Docker-Compose:

```bash
sudo curl -sSL https://get.docker.com/ | sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.14.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```


## Download DivvyCloud Repository 

After installing Docker and Docker-Compose, you will need to download the 
DivvyCloud repository from GitHub:

```bash
git clone https://github.com/DivvyCloud/QuickStart.git divvycloud
```

## Set Export Variables 

When registering your installation, DivvyCloud checks the values of
certain registration variables, specifically your company information, your
name, and your email. For example, Jane Doe at Acme Corporation would use
the following export variables:

```bash
export COMPANY_NAME="Acme Corporation"
export CONTACT_NAME="Jane Doe"
export CONTACT_EMAIL="jane.doe@acmecorp.com"
```

## Start DivvyCloud with Docker Compose

Now you are ready to start DivvyCloud. You can run DivvyCloud in the foreground 
using the first command or in the background by using the second command. Both 
commands assume you are in the 'divvycloud' directory. 

To run DivvyCloud in the foreground and see logging information in your 
terminal, use:
```bash
sudo -E /usr/local/bin/docker-compose up
```

or to run DivvyCloud in the background, use: 
```bash
sudo -E /usr/local/bin/docker-compose up -d
```

## Configure DivvyCloud

After DivvyCloud has completed its launch, you can configure your DivvyCloud 
installation by connecting to your instance using a browser via its public IP 
address, e.g., http://[ip_address_of_your_DivvyCloud_installation]/  

NOTE: If you are running docker-compose locally, you can connect via 
[http://localhost:8001](http://localhost:8001).

The first page you will see is an administrator account creation page. On the 
page, you will enter your name and email address and create a userid and 
password. Your userid can be your email address, but it doesn't have to be. 
Your password must be at least 12 characters in length.

After you have created your administrator account, you will be asked to log 
into DivvyCloud with your administrator account credentials. When you do, 
you can add your cloud accounts to start harvesting data and explore bot 
templates to select bots to customize and/or activate (see 
http://docs.divvycloud.com under "Cloud Support" and "DivvyCloud => 
Templates Listing" respectively.) 

## Stop DivvyCloud

To stop DivvyCloud, use the following from the 'divvycloud' directory: 
```bash
sudo -E /usr/local/bin/docker-compose down -d
```

## Upgrade DivvyCloud

To upgrade DivvyCloud, use the following from the 'divvycloud' directory: 
```bash
sudo -E /usr/local/bin/docker-compose pull
sudo -E /usr/local/bin/docker-compose down
sudo -E /usr/local/bin/docker-compose up -d
```

## Running DivvyCloud with plugins
DivvyCloud can be started with plugins to customize your installation 
in several ways.

[Read about plugins here.](http://docs.divvycloud.com/api/17.05/plugins.html)

In the context of docker-compose, we can mount a directory called plugins 
into the interface server container when it starts. Reloading plugin changes
requires restarting the whole suite as described above.

Mounting volumes can be done by passing arguments when starting a container. However,
since we're using the compose file it's best to add a single line to the `docker-compose.yml`
file.

```
  interfaceserver:
    image: divvycloud/botfactory
    environment:
      VIRTUAL_ENV: /
      VIRTUAL_HOST: "*"
    entrypoint:
    - /entrypoint.sh
    links:
    - redis:redis
    - mysql:mysql
    ports:
    - 8001:8001/tcp
    command:
    - ./uwsgi.sh
    volumes:               <-- this is new!
    - ./plugins:/plugins   <-- this is new!
```
Add a directory called plugins in the cloned repo directory.

An example plugin which will render a new page in the application can be found on GitHub called
[SkeletonPlugin](https://github.com/DivvyCloud/SkeletonPlugin). Clone this plugin into the 
`plugins` directory you just made.

```
cd plugins
git clone https://github.com/DivvyCloud/SkeletonPlugin.git helloworld
```
Restart the suite.

## Logging
Logs will be placed in the directory where `docker-compose up` is invoked from
and are named by application process and date.

```
# Example
./logs/DivvyInterfaceServer-2016-11-02-0.log
```

## Note about Installing DivvyCloud as Non-Root User

If you would like to use Docker as a non-root user, you will need to 
add your user, e.g., jane_doe, to the "docker" group with something like:
```bash
sudo usermod -aG docker jane_doe
```

Then, you will need to log out and back in for the change to take effect.

Of note, adding a user to the "docker" group will grant that user the 
ability to run containers, which can be used to obtain root privileges 
on the docker host. See https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface 
for more information.

## Note about CentOS with SE Linux

SE Linux prevents Docker from writing MySQL data to the 
host system. The workaround is to run this command from the 'divvycloud' 
directory:
```bash
chcon -Rt svirt_sandbox_file_t data
```
