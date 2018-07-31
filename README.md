DevOps Pairing Exercise
=======================

# Goal

Automate the creation of a web server, and a script to check the server is up.

# Prerequisites

Use the AWS account credentials provided.

# The Task

You are required to set up a new server in AWS. It must:

* Be publicly accessible.
* Run Nginx.
* Serve a `/version.txt` file, containing only static text representing a version number, for example:

```
1.0.6
```

# Mandatory Work

Fork this repository.

* Provide instructions on how to create the server.
* Use a configuration management tool (such as Puppet, Chef or Ansible) to bootstrap the server.
* Provide a script that can be run periodically (and externally) to check if the server is up and serving the expected version number. 
* Alter the README to contain the steps required to:
  * Create the server.
  * Run the health check script.

Give user `aeells|schmiegelow` access to your fork. 
Feel free to ask questions as you go if anything is unclear, confusing, or just plain missing.

# Extra Credit

This exercise is timeboxed, but if any of these shortcut the process by making it easier in the long-run they might be worth considering up front. We won't mark you down for not doing the extra credits, but if you want to give them a go...

* Put the server behind a load balancer.
* Run Nginx inside a Docker container.
* Make the checker script SSH into the instance, check if Nginx is running and start it if it isn't.

# Questions

#### What scripting languages can I use?

Any you like. You’ll have to justify your decision. We use Bash, Python, Groovy and JavaScript internally. Please pick something you're familiar with, as you'll need to be able to discuss it.

#### What will you be grading me on?

Scripting skills, elegance, understanding of the technologies you use, security, documentation.

#### Will I have a chance to explain my choices?

Hopefully this will emerge as we pair and converse. 
But feel free to comment your code, or put explanations in a pull request within the repo.
