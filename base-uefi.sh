#!/bin/bash

echo 'for exemple Europe/Kiev'
read -p 'time_zone: ' time_zone

ln -sf /usr/share/zoneinfo/$time_zone /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=en_US" >> /etc/vconsole.conf
echo "FONT=cur-sun16" >> /etc/vconsole.conf
read -p 'hostaname: ' >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 Arch.localdomain arch" >> /etc/hosts


pacman -S grub efibootmgr networkmanager iterminus-font i3-gaps polybar kitty vim base-devel nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader lib32-opencl-nvidia opencl-nvidia libxnvctrl bluez bluez-utils pulseaudio-bluetooth blueman lightdm lightdm-gtk-greeter
pacman -S --noconfirm xf86-video-amdgpu

grub-install --efi-directory=/boot/efi/ --removable

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable lightdm

read -p 'User name: ' $user_name

useradd -m -g users -W wheel $user_name

echo 'root passwd'
passswd

echo $user_name 'passwd'
passwd $user_name

mkinitcpio -P

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"

