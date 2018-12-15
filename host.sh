#!/bin/bash

action=$1
domain=$2

if [ "$action" != "add" ] && [ "$action" != "remove" ]
	then
		echo $"You should specify the action (add or remove)"
		exit 1
fi

if [ "$domain" == '' ]; then
	echo $"You should specify the domain name"
	exit 1;
fi

if [ "$(whoami)" != 'root' ]; then
	echo $"You have no permission to run $0 as non-root user. Use sudo"
	exit 1;
fi


if [ "$action" == 'add' ]
	then
		### Add domain in /etc/hosts
		if ! echo "127.0.0.1	$domain" >> /etc/hosts
		then
			echo $"ERROR: Not able to write in /etc/hosts"
			exit;
		else
			echo -e $"Host added to /etc/hosts file \n"
		fi
	else
		### Delete domain in /etc/hosts
		newhost=${domain//./\\.}
		sed -i "/$newhost/d" /etc/hosts
		echo -e $"Host $domain removed from /etc/hosts file \n"
fi


