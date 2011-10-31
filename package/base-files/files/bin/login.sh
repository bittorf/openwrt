#!/bin/sh
# Copyright (C) 2006-2011 OpenWrt.org

ssh_server_exists() {
	[ -e /usr/sbin/dropbear ] && return 0
	[ -e /usr/sbin/sshd ] && return 0
}

if grep -qs '^root:[^!]' /etc/passwd /etc/shadow && [ -z "$FAILSAFE" ]; then
	echo "Login failed."
	ssh_server_exists && exit 0
else
	cat << EOF
 === IMPORTANT ============================
  Use 'passwd' to set your login password
  this will disable telnet and enable SSH
 ------------------------------------------
EOF
fi

exec /bin/ash --login