#!/bin/bash
date_time=`date`
vm_ip=1.1.1.1

if curl -k -s --head https://$vm_ip/test.txt | grep "200 OK"
  then
    echo "The HTTPs server is up!"
  else
    echo "The HTTPs server is down!"
    echo "Server is down at $date_time" >> log.log
fi

if curl -k -s  https://$vm_ip/test.txt | grep "1.0.6"
  then
    echo "The  server has the stable version"
  else
    echo "The version was changed"
    echo "Version changed at $date_time" >> log.log
fi