Create nginx server azure
=========================
# General information
This service has stack of bash+ansible+az cli
This service has these steps:
1. create an VM on azure cloud(the os is centos)
2. create network and firewall rules
3. create load balancer
4. configure server (install deps)
5. install web server
6. create selfsigned certs




# Before you started
configure this cloud shell by using this article: https://docs.microsoft.com/ru-ru/azure/cloud-shell/quickstart
In case your cloud is not configured to use ansible do these steps:
Open cloud cli (!use bash)
* enter this comand to show account list:
```
az account list
```
* export parameter:
```
export AZURE_SUBSCRIPTION_ID=<your-subscription-id>
```

<your-subscription_id> - change this (the information in previous step

* generate the ssh key to access the vm's

```
ssh-keygen -t rsa -b 4096
```

# Download the source code and structure description

To get this service download  it in your cloud shell home directory  by using: 

```
git clone https://github.com/f4th3r/devops-interview-task
```

Strucure:

create_ss_cert.yml  create_vm_azure.yml  firstconnect.yml  host  lb  nginx  scripts   tmp

ROOT dir contains:
* create_ss_cert.yml  - ansible playbook to create certs
* create_vm_azure.yml - ansible playbook to create vm 
* firstconnect.yml    - ansible playbook to first connect to vm 
* host - host file for vm connection from cloud shell 


Dir lb contains:

createlb.yml - DEPRICATED
* createlb.yml ansible playbook to create lb  

 
 
Dir nginx  contains:
install_set_nginx.yaml  nginx.conf              ssl.conf                static.conf             test.txt

* install_set_nginx.yaml  - ansible playbook to create nginx
* nginx.conf              - nginx config
* ssl.conf                - ssl config
* static.conf             - 80 port config
* test.txt                - the main page with version

Dir scripts contains:

create_start_service.sh  daemon_health_check_443.sh  health_check_443.sh  log.log

* create_start_service.sh  - the main scripts
* daemon_health_check_443.sh  - start daemon to healthcheck script
* health_check_443.sh  - healphcheck script
* log.log  - file logs to log healph checks failds

Dir tmp  - for temp files





# HOWTO configure
If you want to change parameters such as:

* ResourceGroup            - Resource group in az
* myVnet                   - Virtal network in az 
* mySubnet                 - Subnet that will be created in az
* myPublicIP               - The name of intrface with external ip
* myNetworkSecurityGroup   - The security group with firewall rules
* MyNIC                    - The vm network interface
* myVM                     - The name of VM in az with web server       
* MyLb                     - The load balancer name
* PublicIPMyLb             - The lb name interface 
* port_for_ssh             - the ssh port(front port of LB). The destination port is 22          

Change  main script in config section:  scripts/create_start_service.sh



# HOWTO start
To start creating and configure service just run:
1. go to scripts catalog:

```
cd scripts
```
2. start script:

```
./create_start_service.sh
```
PS:
The are to ways to start this script. 
1. The more secure way is just starting like in step 2.
2. The second one is

```
./create_start_service.sh username password
```
* username - vm admin user
* password - vm admin password 


After starting script it will ask for username and password. 
You will see the process of installation.
It will stop on the first connect step.

* The authenticity of host '[ip]:port ([ip]:port)' can't be established.

Just say yes and push <ENTER>.

If you want to use it without promt set StrictHostKeyChecking no in your /etc/ssh/ssh_config.
!!!!It will work only in ansible vm host. And Wont work in cloud shell because of permissions.

The process will take drom 3-5 minutes.
After finishing you will see the credentials and ip adress to use ssh and https.




# Testing

The are 2 scripts to start simple check.

just go to 

```
cd scripts
```
change the ip adrees in check create_start_service.sh sript(use your new ip of balancer in previous step) 

To start check 

```
./health_check_443.sh
```
It will check version and web server health


If you want to start in background mode

```
./daemon_health_check_443.sh &&
```
This mode start check it every 5 second and if the service down or version is changed(not that axpected) 
it will echo this and write the log.

To kill process just use
```
ps aux | grep daemon

````
and kill the process by id

```
kill process_name
```


# Delete service
To delete service just use command:

az group delete --name  myResourceGroup

myResourceGroup - id group with that service
!!!!DONT USE this command in case you have  another service in this namespace. 
This command delete all services in this group














