#!/bin/bash
if [[ "$1" == "-f" ]]
 then
  if [[ ! -z "$3" ]]
   then
    if [[ -e "$2" ]]
     then
     ##
      login=`cut -d: -f1 $2 | grep -Fxn "$3"`
      #echo "$login"
      home_dirs=`cut -d: -f6 $2`
      num="${login%:*}"
      #echo "num is $num"
     ##
      if [[ "$login" == "" ]]
       then
        echo "the login $3 is not found" >&2
        exit 1
      else
        echo "$home_dirs" | sed -n "$num"p
       fi
    else
     echo "the file $2 is not found" >&2
     exit 2
     fi
  else
   if [[ -e "$2" ]]
    then
     ##
     login=`cut -d: -f1 $2 | grep -Fxn "$USER"`
     #echo "$login"
     home_dirs=`cut -d: -f6 $2`
     num="${login%:*}"
     #echo "num is $num"
     ##
     if [[ "$login" == "" ]]
       then
        echo "the login $USER is not found" >&2
        exit 1
     else
       echo "$home_dirs" | sed -n "$num"p
       fi
   else
    echo "the file $2 is not found" >&2
    exit 2
    fi
   fi
else
   etc_file="/etc/passwd"
   if [[ ! -z "$1" ]]
   then
    ##
     login=`cut -d: -f1 $etc_file | grep -Fxn "$1"`
     #echo "$login"
     home_dirs=`cut -d: -f6 $etc_file`
     num="${login%:*}"
     #echo "num is $num"
    ##
    if [[ "$login" == "" ]]
    then
     echo "the login $1 is not found" >&2
     exit 1
    else
     echo "$home_dirs" | sed -n "$num"p
    fi
   else

     ##
     login=`cut -d: -f1 $etc_file | grep -Fxn "$USER"`
     #echo "$login"
     home_dirs=`cut -d: -f6 $etc_file`
     num="${login%:*}"
     #echo "num is $num"

     ##

    echo  "$home_dirs" | sed -n "$num"p
   fi

fi
