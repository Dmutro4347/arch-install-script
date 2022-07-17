#!/bin/bash
echo 'please choose your connection etho or wlan'

read -p 'connection: ' connection

if [[ "$connection" == "wlan" ]]; then
        sudo iw wlan0 scan | grep SSID
        read -p 'wifi name: ' name_wifi
        read -p 'password wifi: ' password_wifi
        nmcli dev wifi connect $name_wifi password $password_wifi
elif [[ "$connection" == "etho" ]]; then
        echo "nice you don't need to startup wifi connection"
else
	echo "you don't connect to the internet"

fi

read -p "please choose karnel linux, zen or lts: " karnel

if [[ "$karnel" == "zen" ]]; then
	pacstrap /mnt base linux-zen linux-zen-headers linux-firmware git
elif [[ "$karnel" == "linux" ]]; then
	pacstrap /mnt base linux linux-firmware git
elif [[ "$karnel" == "lts" ]]; then
	pacstrap /mnt base linux-lts linux-lts-headers linux-firmware git
fi

genfstab /mnt -U >> /mnt/etc/fstab

arch-chroot /mnt
