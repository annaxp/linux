#!/bin/bash

echo "========================================"
echo "script run" 
groupadd web
if [[ $? == 0 ]] ; then
    echo "success"
else
    echo "The gruop already exists"
    echo `cat /etc/group | grep web`
fi
echo "1 ========================================"

groupadd geekbrains
if [[ $? == 0 ]] ; then
    echo "success"
else
    echo "The gruop already exists"
    echo `cat /etc/group | grep geekbrains`
fi
echo "2 ========================================"
useradd -m -g web -G geekbrains -u 143 -s /bin/bash  rockstar
if [[ $? == 0 ]] ; then
    echo "success"
else
    echo "The user rockstar already exists"
    echo `cat /etc/passwd | grep rockstar`
    echo `id rockstar`
fi
echo "3 ========================================"

MYUID=`id rockstar | awk '{print $1}' | sed "s/uid=//g" | sed "s/(rockstar)//g"`
if [[ $MYUID == 143 && $? == 0 ]] ; then
    echo "success UID user rockstar alredy  $MYUID"
else	
   usermod -u 143 rockstar
   echo "success UID user rockstar alredy  $MYUID"
fi

echo "4 ========================================"
MYGROUP=`id rockstar | awk '{print $2}' | sed "s/gid=....//g"`
if [[ $MYGROUP == "(web)" && $? == 0 ]] ; then
    echo "success GID user rockstar alredy  $MYGROUP"
else
    usermod -g web rockstar
   echo "GID already $MYGROUP"
fi
echo "5 ========================================"
MYGRS=`id rockstar | awk '{print $3}' |sed "s/.*=....(.*),....//g"`
if [[ $MYGRS == "(geekbrains)" && $? == 0 ]] ; then
    echo "success GROUPS user rockstar alredy  $MYGRS"
else
    usermod -aG geekbrains rockstar
   echo "GROUPS already $MYGRS"
fi

