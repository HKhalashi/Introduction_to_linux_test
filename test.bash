#!bin/bash
if [[ "$1" == "-f" ]]
then
group=`cut -d: -f1 $1| grep -Fxn "$2"`
echo "$group"
else
group = `cut -d: -f1 /etc/group | grep -Fxn "$1"`
echo "$group"
