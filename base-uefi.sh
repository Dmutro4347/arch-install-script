#!/bin/bash

ln -sf /usr/share/zoneinfo/Europe/Kiev /etc/localtime
hwclock --systohc
sed -i '178s/.//' /etc/locale.gen
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=en_US" >> /etc/vconsole.conf
echo "FONT=cur-sun16" >> /etc/vconsole.conf
echo "Arch" >> /etc/hostname
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 Arch.localdomain arch" >> /etc/hosts


pacman -S grub efibootmgr networkmanager iterminus-font i3-gaps polybar kitty vim base-devel nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader lib32-opencl-nvidia opencl-nvidia libxnvctrl bluez bluez-utils pulseaudio-bluetooth blueman
pacman -S --noconfirm xf86-video-amdgpu

grub-install --efi-directory=/boot/efi/ --removable

grub-mkconfig -o /boot/grub/grub.cfg

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable lightdm

read -p 'User name: ' user-name

useradd -m -g users -W wheel user-name

echo 'root passwd'
passswd

echo $user-name 'passwd'
passwd $user-name

mkinitcpio -P

printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"
