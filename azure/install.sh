#!/bin/sh

export VPN_IPSEC_PSK=$1
export VPN_USER=$2
export VPN_PASSWORD=$3

# Tunggu 60 detik untuk apt/dpkg lock
sleep 60

wget https://git.io/vpnsetup -O vpnsetup.sh && sh vpnsetup.sh
