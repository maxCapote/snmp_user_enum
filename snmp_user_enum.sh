#!/bin/bash

if [ $# -lt 2 ]; then
  echo "usage: ./snmp_user_enum.sh [positional_arg_1_targets] [positional_arg_2_users]"
  exit 2
fi

bold=$(tput bold)
normal=$(tput sgr0)
levels=(noAuthNoPriv authNoPriv authPriv)

while read line ; do
  targets+=("$line")
done < $1

while read line ; do
  usernames+=("$line")
done < $2

for target in "${targets[@]}"; do
  for username in "${usernames[@]}"; do
    for level in "${levels[@]}"; do
      echo 'target :' ${bold}"$target"${normal}
      echo 'username :' ${bold}"$username"${normal}
      echo 'security level :' ${bold}"$level"${normal}
      if [[ "$level" == "${levels[0]}" ]]; then
        snmpwalk -v 3 -l "${level}" -u "${username}" "${target}" | head -n 1
      elif [[ "$level" == "${levels[1]}" ]]; then
        snmpwalk -v 3 -l "${level}" -u "${username}" -a MD5 -A password "${target}" | head -n 1
      else
        snmpwalk -v 3 -l "${level}" -u "${username}" -a SHA -A password -x AES -X password "${target}" | head -n 1
      fi
      echo
    done
  done
done

exit 0
