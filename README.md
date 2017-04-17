# BotFactory Quick Start using Docker Compose 

The fastest and most consistent way to launch BotFactory is to use Docker 
Compose. This quick start guide provides instructions on how to use Docker 
Compose to launch BotFactory and all of its service dependencies as containers.

## Provision BotFactory Instance

BotFactory supports two primary Linux distributions. They are:

 - Ubuntu 14.04+ 
 - CentOS 6+ (see note at end of instructions)

BotFactory requires an instance with at least:

 - 4 cores
 - 6 Gb of memory
 - 20 Gb root volume

If using AWS, we recommend using a m4.xlarge instance, which has 4 cores and 
16 Gb, and attaching a volume with 30 Gb.

## Install Docker and Docker-Compose

First, we need to install Docker and Docker-Compose to use them for our 
installation. (For more information about Docker-Compose, please see 
https://docs.docker.com/compose/install/)

After logging into your BotFactory instance, run the following commands to 
install Docker and Docker-Compose:

```bash
sudo curl -sSL https://get.docker.com/ | sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```

## Download BotFactory Repository 

After installing Docker and Docker-Compose, you will need to download the 
BotFactory repository from GitHub:

```bash
git clone https://github.com/DivvyCloud/QuickStart.git
```

## Update register.env with Export Variables 

When registering your installation of BotFactory, Docker checks the values of 
specific registration variables. In the QuickStart directory, edit the file 
'register.env' to include your company information, your name, and your email. 
When doing so, use underscores in lieu of spaces. For example, Jane Doe at 
Acme Corporation's 'register.env' would be updated like the following:

```bash
export COMPANY_NAME="Acme_Corporation"
export CONTACT_NAME="Jane_Doe"
export CONTACT_EMAIL="jane.doe@acmecorp.com"
```

## Start BotFactory with Docker Compose

Now you are ready to start BotFactory. You can run BotFactory in the foreground 
using the first command or in the background by using the second command. Both 
commands assume you are in the QuickStart directory.

To run BotFactory in the foreground and see logging information in your 
terminal, use:
```bash
sudo -E /usr/local/bin/docker-compose up
```

or to run BotFactory in the background, use: 
```bash
sudo -E /usr/local/bin/docker-compose up -d
```

## Configure BotFactory

After BotFactory has completed its launch, you can configure your BotFactory 
installation by connecting to your instance using a browser via its public IP 
address, e.g., http://[ip_address_of_your_BotFactory_installation]/  

The first page you will see is an administrator account creation page. On the 
page, you will enter your name and email address and create a userid and 
password. Your userid can be your email address, but it doesn't have to be. 
Your password must be at least 12 characters in length.

After you have created your administrator account, you will be asked to log 
into BotFactory with your administrator account credentials. When you do, 
you can add you cloud accounts (see http://docs.divvycloud.com under 
"Cloud Support") to start harvesting data and explore Bot templates (under 
"BotFactory => Templates Listing") to select which bots to customize and/or 
activate.

### Note about CentOS with SE Linux

SE Linux will prevent Docker from writing MySQL and ElasticSearch data to the 
host system. The work around for this is to run these commands:

```bash
chcon -Rt svirt_sandbox_file_t esdata
chcon -Rt svirt_sandbox_file_t db
```
