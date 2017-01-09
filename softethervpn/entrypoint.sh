#!/bin/bash

LOG_DIR=/var/log/vpnserver

[[ ! -d "${LOG_DIR}/security_log" ]] && mkdir -p ${LOG_DIR}/security_log
[[ ! -d "${LOG_DIR}/packet_log" ]] && mkdir -p ${LOG_DIR}/packet_log
[[ ! -d "${LOG_DIR}/server_log" ]] && mkdir -p ${LOG_DIR}/server_log

ln -s /var/log/vpnserver/*_log /usr/vpnserver/

set -e
if [ ! -f /usr/vpnserver/vpn_server.config ]; then
	: ${USERNAME:=user$(cat /dev/urandom | tr -dc '0-9' | fold -w 4 | head -n 1)}

	printf '=%.0s' {1..24} && echo -e "\nUSERNAME : ${USERNAME}"

	#if [[ $PASSWORD ]]; then
	#	echo 'PASSWORD : <use the password specified at -e PASSWORD>'
	#else
	#	PASSWORD=$(cat /dev/urandom | tr -dc '0-9' | fold -w 20 | head -n 1 | sed 's/.\{4\}/&./g;s/.$//;')
	#	echo "PASSWORD : ${PASSWORD}"
	#fi
	[[ ! $PASSWORD ]] && PASSWORD=$(cat /dev/urandom | tr -dc '0-9' | fold -w 20 | head -n 1 | sed 's/.\{4\}/&./g;s/.$//;')
	echo "PASSWORD : ${PASSWORD}"
	[[ $PSK ]] && { echo "PSK      : $PSK"; } || { echo "PSK      : notasecret" && PSK=${PSK:-notasecret}; }

	printf '=%.0s' {1..24} && echo

	/usr/bin/vpnserver start 2>&1 > /dev/null

	# while-loop to wait until server comes up
	# switch cipher
	while : ; do
		set +e
		/usr/bin/vpncmd localhost /SERVER /CSV /CMD ServerCipherSet DHE-RSA-AES256-SHA 2>&1 > /dev/null
		[[ $? -eq 0 ]] && break
		set -e && sleep 1
	done

	# enable L2TP_IPsec
	/usr/bin/vpncmd localhost /SERVER /CSV /CMD IPsecEnable /L2TP:yes /L2TPRAW:yes /ETHERIP:no /PSK:${PSK} /DEFAULTHUB:DEFAULT

	# enable SecureNAT
	/usr/bin/vpncmd localhost /SERVER /CSV /HUB:DEFAULT /CMD SecureNatEnable

	# add user
	/usr/bin/vpncmd localhost /SERVER /HUB:DEFAULT /CSV /CMD UserCreate ${USERNAME} /GROUP:none /REALNAME:none /NOTE:none
	/usr/bin/vpncmd localhost /SERVER /HUB:DEFAULT /CSV /CMD UserPasswordSet ${USERNAME} /PASSWORD:${PASSWORD}

	export PASSWORD='**'

	# set password for hub
	HPW=$(cat /dev/urandom | tr -dc 'A-Za-z0-9' | fold -w 16 | head -n 1)
	/usr/bin/vpncmd localhost /SERVER /HUB:DEFAULT /CSV /CMD SetHubPassword ${HPW}

	# set password for server
	SPW=$(cat /dev/urandom | tr -dc 'A-Za-z0-9' | fold -w 20 | head -n 1)
	echo "SPW      : ${SPW}"
	/usr/bin/vpncmd localhost /SERVER /CSV /CMD ServerPasswordSet ${SPW}

	/usr/bin/vpnserver stop 2>&1 > /dev/null

	# while-loop to wait until server goes away
	set +e && while pgrep vpnserver > /dev/null; do sleep 1; done && set -e

	echo [initial setup OK]
fi

echo [Start server]
exec /usr/bin/vpnserver execsvc

exit $?