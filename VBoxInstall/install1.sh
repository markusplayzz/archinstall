# Only UEFI
################# Load Keyboard #################
# loadkeys de-latin1
################# Format Partitions before running! #################
# gdisk /dev/nvme0n1
# o - y
# n - Enter - Enter - +8G - 8200
# n - Enter - Enter - Enter - 8300
# w - y

# Get best package mirrors
pacman -Sy --noconfirm
pacman -S reflector --noconfirm
reflector -c "AT" -f 12 -l 10 -n 12 --save /etc/pacman.d/mirrorlist

# Format disks
mkswap /dev/nvme0n1p2
mkfs.ext4 /dev/nvme0n1p3

# Mount parts

swapon /dev/nvme0n1p2
mount /dev/nvme0n1p3 /mnt

# Installation
timedatectl set-ntp true
pacman -Sy archlinux-keyring
pacstrap /mnt base base-devel linux linux-firmware vi vim nano
genfstab -U /mnt >> /mnt/etc/fstab

# Get next script
curl https://raw.githubusercontent.com/markusplayzz/archinstall/main/VBoxInstall/install2.sh -o /mnt/install2.sh

# Enter new system
# arch-chroot /mnt
