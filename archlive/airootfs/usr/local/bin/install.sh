#!/bin/bash
loadkeys trq
clear
echo "Do you have wifi? if yes, choose the network and connect. if no, plug your cable before answering[y/n]"
read -r YESNO
if [[ ${YESNO} = "y" ]]; then
	nmtui
fi
clear
echo "Checking your internet connection"
if ping -c 1 -q google.com >&/dev/null; then
	echo "You have internet access, moving forward"
	sleep 2
	clear
else
	echo "You don't have internet access, aborting"
	exit 0
fi
echo "updating system clock"
timedatectl >&/dev/null
lsblk | grep disk
echo "select disk to change the partition table in[ex. nvme0n1]"
read -r DISK
clear
echo "Information about partitions: if you have at least 8GB of RAM, swap partitions aren't recommended."
echo "But if you have have less, a swap partition that's equal to your RAM is recommended."
echo "512MB of boot partition is required, but if you want you can have one up to 1GB, anything above 1GB isn't recommended."
echo "everything else should be the root partition, the minimum size of root partition is 10GB but every bit helps"
echo "so if you have disk size, give it[input \"ok\" when you are ready"
read -r YESNO
cfdisk "/dev/$DISK"
clear
lsblk
echo "Input your boot partition[ex. nvme0n1p1]"
read -r BOOTNAME
BOOT="/dev/$BOOTNAME"
echo "Input your root partition[ex. nvme0n1p2]"
read -r ROOTNAME
ROOT="/dev/$ROOTNAME"
echo "If you have a swap partition then input it, else input n[ex. nvme0n1p3 or n]"
read -r SWAPNAME
if [[ ${SWAPNAME} != "n" ]]; then
	SWAP="/dev/$SWAPNAME"
fi
mkfs.vfat -F 32 "$BOOT" >&/dev/null
mkfs.ext4 "$ROOT" >&/dev/null
if [[ ${SWAPNAME} != "n" ]]; then
	mkswap "$SWAP" >&/dev/null
fi
mount "$ROOT" /mnt
mount --mkdir "$BOOT" /mnt/boot
if [[ ${SWAPNAME} != "n" ]]; then
	swapon "$SWAP"
fi
echo "bootstraping"
pacstrap -K /mnt base pipewire pipewire-alsa pipewire-jack pipewire-pulse libreoffice-fresh plasma-meta krusader ranger btop neovim thunderbird firefox geogebra code neovim blueman plasma-nm linux linux-firmware networkmanager freecad blender nano man-db e2fsprogs ntfs-3g dosfstools grub efibootmgr gnome gdm
genfstab -U /mnt >> /mnt/etc/fstab
echo "entering chroot"
arch-chroot /mnt /bin/bash -i << EOF
#!/bin/bash
ln -sf /usr/share/zoneinfo/Europe/Istanbul /etc/localtime
hwclock --systohc >&/dev/null
echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen
locale-gen >&/dev/null
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=trq" >> /etc/vconsole.conf
echo "edarch-pc" >> /etc/hostname
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB
cat >> /etc/default/grub << EOR
GRUB_DEFAULT=0
GRUB_TIMEOUT=5
GRUB_DISTRIBUTOR="EdArch"
GRUB_CMDLINE_LINUX_DEFAULT="loglevel=3 quiet"
GRUB_CMDLINE_LINUX=""
GRUB_PRELOAD_MODULES="part_gpt part_msdos"
GRUB_TIMEOUT_STYLE=menu
GRUB_TERMINAL_INPUT=console
GRUB_GFXMODE=auto
GRUB_GFXPAYLOAD_LINUX=keep
GRUB_DISABLE_RECOVERY=true
GRUB_DISABLE_OS_PROBER=false
EOR
grub-mkconfig -o /boot/grub/grub.cfg
echo "root:root" | chpasswd
ln -s /usr/lib/systemd/system/gdm.service /etc/systemd/system/display-manager.service
ln -s /usr/lib/systemd/system/NetworkManager.service /etc/systemd/system/multi-user.target.wants/NetworkManager.service
ln -s /usr/lib/systemd/system/NetworkManager-dispatcher.service /etc/systemd/system/dbus-org.freedesktop.nm-dispatcher.service
ln -s /usr/lib/systemd/system/NetworkManager-wait-online.service /etc/systemd/system/network-online.target.wants/NetworkManager-wait-online.service
mkdir -p /home/user
useradd -d /home/user -G users,video,audio,wheel user
echo "user:user" | chpasswd
chown user /home/user
mkdir /home/user/Downloads
mkdir /home/user/Documents
mkdir /home/user/Desktop
mkdir /home/user/Videos
mkdir /home/user/Pictures
mkdir /home/user/Music
chown user /home/user/Downloads
chown user /home/user/Documents
chown user /home/user/Desktop
chown user /home/user/Videos
chown user /home/user/Pictures
chown user /home/user/Music
EOF
echo "rebooting"
sleep 3
umount -R /mnt
reboot
