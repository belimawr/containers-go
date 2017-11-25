#!/usr/bin/env bash

apt-get update
apt-get install -y zsh git emacs25-nox vim parted tmux

chsh -s /bin/zsh vagrant

parted --align optimal /dev/sda mkpart primary ext4 10632MB 53687MB
mkfs.ext4 /dev/sda3
mkdir -p /mnt/containerfs
echo "/dev/sda3	/mnt/containerfs	ext4	defaults,auto	0	2" >> /etc/fstab
mount -a
