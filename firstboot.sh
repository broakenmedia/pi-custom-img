#!/bin/bash

sudo raspi-config nonint do_vnc 0

sleep 2m
macadd=$( ip -brief add | awk '/UP/ {print $1}' | sort | head -1 )
if [ ! -z "${macadd}" ]
then
  macadd=$( sed 's/://g' /sys/class/net/${macadd}/address )
  sed "s/raspberrypi/${macadd}/g" -i /etc/hostname /etc/hosts
fi

curl -fsSL https://tailscale.com/install.sh | sh

wait

sudo tailscale up --authkey <AUTHKEY
