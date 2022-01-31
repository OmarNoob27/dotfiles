#/bin/sh

status=$(mpc status | grep play)

if [ -n "$status" ]
then
   mpc pause >> /dev/null
else
   mpc play >> /dev/null
fi
