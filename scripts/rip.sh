#!/bin/sh

ip=$(curl -s icanhazip.com);

if [[ "$BLOCK_BUTTON" -eq 1 ]];
then
	netname=$(whois $ip | grep '^netname:' | awk '{print $2}' | tail -1);
	echo "$netname"
else
	echo "$ip"
fi
