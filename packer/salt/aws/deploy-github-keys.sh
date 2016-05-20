#!/bin/bash
[ ! -f /etc/github.keys ] && echo "No keys found" && exit 0
cat /etc/github.keys|tr "," "\n"| while read github_user; do
  [ -z ${github_user} ] && break
  KEYS=$(wget https://github.com/${github_user}.keys -O -)
  [ $? -gt 0 ] && echo "Error importing ${github_user} key" && continue
  echo "$KEYS" >> /home/ubuntu/.ssh/authorized_keys
  echo "${github_user} keys imported"
done

echo "Done"