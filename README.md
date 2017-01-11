# Docker Compose for Quick Start 

This compose file is the fastest way to get up and running with DivvyCloud.
All service dependencies are spun up with DivvyCloud as containers.

## Min Specs and pre-reqs
DivvyCloud requires atleast 6 Gigs of memory and 4 cores. 
If using AWS, we recommend using a  m4.xlarge as a base spec for the quickstart system. 

Supported distributions are :

 - Ubuntu 14.04+ 
 - CentOS 6+

docker-compose is also required for the DivvyCloud quickstart setup. 
Please see  https://docs.docker.com/compose/install/  for more information regarding docker-compose installation

## Install docker and docker-compose

Install the latest version of docker and docker-compose by running:

```bash
sudo curl -sSL https://get.docker.com/ | sh
sudo curl -L "https://github.com/docker/compose/releases/download/1.9.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
```


## Setup 

Once Docker and docker-compose is up and running please sync down this repository:
```bash
git clone https://github.com/DivvyCloud/QuickStart.git
```
All commands below assume your currenty working directory is the Quickstart/ directory found in this repo. 

## First : Export registration variables 
The DivvyCloud docker setup looks for specific variables for automatic registration
Please make sure to export the following variables:

```bash
export COMPANY_NAME=my_company
export CONTACT_NAME=my_name
export CONTACT_EMAIL=my_email
````

## Second : Start DivvyCloud using Docker Compose ##

```bash
cd QuickStart
sudo -E /usr/local/bin/docker-compose up
````

If you want to have the containers run in the background , simply append -d to the docker-compose command. 
```bash
sudo -E /usr/local/bin/docker-compose up -d
```


It will take DivvyCloud a few moments to initialize.   
Connect to in a web browser.  
http://[ip_address_of_system]:8001/  

The first page you will see is a admin setup page.    

## Upgrading the DivvyCloud Docker Environment

```bash
cd QuickStart/
docker-compose pull
docker-compose down
docker-compose up -d
```

### Quick Notes about CentOS w/ SE Linux] ###

SE Linux will prevent Docker from writing to the host system for persisting  
MySQL and ElasticSearch data. The work around for this is :  

```bash
chcon -Rt svirt_sandbox_file_t esdata
chcon -Rt svirt_sandbox_file_t db
```
