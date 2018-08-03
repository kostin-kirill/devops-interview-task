## Questions:

1:
```
Q: What does DevOps mean to you?
A: Looking for a mindset, culture or strategy. Specifically not a team, process or job title.
```

2:
```
Q: What's it for? Why was it born?
A: To reduce the silos and gaps between Development and Operations.
```

3:
```
Q: Describe how you have seen versioning work as part of the deployment/release process.
A: Expect some in-depth detail around maven versions or Jenkins build numbers, or perhaps a centralised versioning service. Maybe symlinks.
   But it should be easy to know if someone is blagging this as it's a very specific question.

(if they struggle with that, the following is easier)

Q: Can you describe "semver" or semantic versioning to me please?
A: Given a version number MAJOR.MINOR.PATCH, increment the:
   MAJOR version when you make incompatible API changes,
   MINOR version when you add functionality in a backwards-compatible manner, and
   PATCH version when you make backwards-compatible bug fixes.
```

4:
```
Q: How have you handled failed deployments? How did you know a deployment has failed?
A: Do they mitigate against with Dev/Prod parity (all environments production-like) and a release process that is the same across all environments?
   Do they run automated smoke tests over the deployment?
   Have they automated rollbacks? I'd expect this at a minimum at the database level with release frameworks such as Liquibase.
```

5:
```
Q: Are you familiar with the 12 factor app? https://12factor.net/
A: Specifically in relation to Ops it's concerned with configuration strategies, logging and administration.
```

6.
```
Q: What is an ELF file?
A: Unix executable file format (Executable and Linkeable Format), common exec file for linux.
```

7.
```
Q: How do you query the type of a cpu using cat?
A: cat /proc/cpuinfo
```

8:
```
Q: What does the 'w' command output?
A: uptime and load average
```

9:
```
Q: What does load average tell us:
A: measures the number of threads that are working and waiting to work (CPU, disk, uninterruptible locks).
```

10:
```
Q: How many hosts does a IP v4 class B network have?
A: 65534.
```

11:
```
Q: What does NAT stand for and when is  it used?
A: Network Address Translation. A NAT Gateway is a host that bridges connectivity between a private network
and the outside networks.
```

12:
```
Q: How do you permenantly configure FD limits in linux
A: By Editing /etc/security/limits.conf and adding appropriate for 'nofiles' (hard and soft) entries.
NB: 'ulimit' is not the right answer, that only affects the current session.
```
