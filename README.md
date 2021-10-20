DevOps Pairing Exercise
=======================

# Goal

Automate the creation of a web server, and provide a healthcheck script to verify the server is up and responding correctly.

# The Task

You are required to provision and deploy a new service in Azure Cloud. It must:

* Be publicly accessible, but *only* on port 80 and 443 via Load Balancer.
* Accessible via SSH with Load balancer inbound NAT on Custom Port
* Run Nginx.
* Generate self signed cert
* Serve a `/version.txt` file, containing only static text representing a version number, for example:

```
1.0.6
```

# Prerequisites

Microsoft temporary account and Azure Subscribtion access will be provided in advance. Please note that you will be granted limited access with contributor on the resourcegroup. Please plan you actions according to the access you will have.

# Mandatory Work

Fork this repository.

* Provide instructions on how to create the server.

* Bootstrap and provision the server using terraform. Use cloud init or a configuration management tool (such as Puppet, Chef or Ansible). Be prepared to justify your decision!

* Provide a heatlhcheck script that can be run externally to periodically check if the server is up and serving the expected version number.

* Alter the README to contain the steps required to:
  * Create the server.
  * Run the healthcheck script.

Give github users `kostin-kirill|infradmin|deep8611` access to your fork.
Feel free to ask questions as you go if anything is unclear, confusing, or just plain missing.

# Extra Credit

This exercise is time-boxed, but if any of these shortcut the process by making it easier in the long-run they might be worth considering up front. We won't mark you down for not doing the extra credits, but if you want to give them a go...

* Make the service resilient in 2 availability zones.
* Run Nginx inside a Docker container or Kubernetes cluster.
* Use the healthcheck script to start Nginx if it is not running.

# If time left

* Create DNS record in Azure subscription with name devopstest(%randomnumber%).try175654609.com
* Issue Let's encrypt certiface for devopstest(%randomnumber%).try175654609.com and www.devopstest(%randomnumber%).try175654609.com and apply to webserver. 


# Questions

#### Can I use Google?

Yes

#### What scripting languages can I use?

Any you like. You’ll have to justify your decision. We use Bash, Python, Powershell internally. Please pick something you're familiar with, as you'll need to be able to discuss it.

#### What will you be grading me on?

Scripting skills, elegance, understanding of the technologies you use, security, documentation.

#### Will I have a chance to explain my choices?

Hopefully this will emerge as we pair and converse.
But feel free to comment your code, or put explanations in a pull request within the repo.
