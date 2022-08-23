#!/bin/bash
envir="/home/max/api_env/.env"
origin=$(grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" ~/api_env/.env)

aws ec2 describe-instances  --region eu-central-1 --filters "Name=tag:Name,Values=master" | grep "PrivateIpAddress" > IP
head -1 IP > IP_addr
replace=$(grep -E -o "([0-9]{1,3}[\.]){3}[0-9]{1,3}" IP_addr)

  for env in $(grep -l -R $origin $envir);

      do
        sed -e "s/$origin/$replace/ig" $env > tempfile.tmp
        mv tempfile.tmp $env  
      done;

