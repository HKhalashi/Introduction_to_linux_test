#!/bin/bash
if [[ "${1:0:1}" == "-" ]]
 then
 if [[ "$1" == "-f" ]]
  then
  if [[ -e "$2" ]]
   then
    group=`cut -d: -f1 $2 | grep -Fxn "$3"`
    if [[ "$group" == "" ]]
    then
    echo "the group $3 doesn't exist" >&2
     exit 1
     else
     #echo "$group"
     users=`cut -d: -f4 $2`
     num="${group%:*}"
     echo "$users" | sed -n "$num"p
     fi
    else
    echo "$2 file does not exist" >&2
    exit 2
   fi else echo "$1 option is invalid" >&2
  exit 2
  fi
else
  group=`cut -d: -f1 /etc/group | grep -Fxn "$1"`
  if [[ "$group" == "" ]]
  then
  echo "the group $1 doesn't exist" >&2
  exit 1
  else
  #echo "$group"
  users=`cut -d: -f4 /etc/group`
  num="${group%:*}"
  echo "$users" | sed -n "$num"p
  fi
 fi
