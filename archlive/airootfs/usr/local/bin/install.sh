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
pacstrap -K /mnt base linux linux-firmware networkmanager nano man-db e2fsprogs ntfs-3g dosfstools grub efibootmgr xf86-video-openchrome xf86-video-nouveau xf86-video-sisusb xf86-video-amdgpu xf86-video-vmware xf86-video-voodoo xf86-video-fbdev xf86-video-intel xf86-video-dummy xf86-video-vesa xf86-video-qxl xf86-video-ati
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
pacman -S --noconfirm pipewire pipewire-alsa pipewire-jack pipewire-pulse gnome gdm
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
pacman -S --noconfirm libreoffice-fresh krusader ranger btop neovim thunderbird firefox geogebra neovim blueman freecad blender gimp krita git base-devel sudo esptool hicolor-icon-theme mypy python-asttokens python-docutils python-jedi python-pillow python-pip python-ptyprocess python-pylint python-send2trash python-setuptools python-wheel python-build python-installer tk python-numpy python-pygame python-cached-property python python-django python-pytest python-humanize python-littleutils python-sqalchemy python-setuptools-scm python-beautifulsoup4 python-flask python-markupsafe python-pandas geckodriver python-requests python-certifi python-debugpy python-importlib-metadata python-inflection python-multidict python-urllib3 alsa-lib gcc-libs glibc gnupg gtk3 libnotify libsecret libxkbfile libxss lsof nss shared-mime-info xdg-info glib2 libdbusmenu-glib gnome-keyring cpio openssl-1.1 libappindicator-gtk3 clang make sh patch dbus-glib libldap libxml2 polkit gnome-common gobject-introspection gtk-doc intltool nemo
git clone https://aur.archlinux.org/yay.git
su user << EOR
cd yay
makepkg
cd ..
EOR
pacman -U --noconfirm yay/yay*.tar.zst
rm -rf yay
cat >> /etc/sudoers << EOR
root ALL=(ALL:ALL) ALL
ALL ALL=(ALL:ALL) ALL
@includedir /etc/sudoers.d
EOR
git clone https://aur.archlinux.org/python-trio-websocket.git
cd python-trio-websocket
makepkg
cd ..
EOR
pacman -U --noconfirm python-trio-websocket/python-trio-websocket*.tar.zst
rm -rf python-trio-websocket
git clone https://aur.archlinux.org/python-outdated.git
cd python-outdated
makepkg
cd ..
EOR
pacman -U --noconfirm python-outdated/python-outdated*.tar.zst
rm -rf python-outdated
git clone https://aur.archlinux.org/python-cheap_repr.git
cd python-cheap_repr
makepkg
cd ..
EOR
pacman -U --noconfirm python-cheap_repr/python-cheap_repr*.tar.zst
rm -rf python-cheap_repr
git clone https://aur.archlinux.org/python-flask-humanize.git
cd python-flask-humanize
makepkg
cd ..
EOR
pacman -U --noconfirm python-flask-humanize/python-flask-humanize*.tar.zst
rm -rf python-flask-humanize
git clone https://aur.archlinux.org/python-pgzero.git
cd python-pgzero
makepkg
cd ..
EOR
pacman -U --noconfirm python-pgzero/python-pgzero*.tar.zst
rm -rf python-pgzero
git clone https://aur.archlinux.org/python-selenium.git
cd python-selenium
makepkg
cd ..
EOR
pacman -U --noconfirm python-selenium/python-selenium*.tar.zst
rm -rf python-selenium
git clone https://aur.archlinux.org/python-birdseye.git
cd python-birdseye
makepkg
cd ..
EOR
pacman -U --noconfirm python-birdseye/python-birdseye*.tar.zst
rm -rf python-birdseye
git clone https://aur.archlinux.org/thonny.git
su user << EOR
cd thonny
makepkg
cd ..
EOR
pacman -U --noconfirm thonny/thonny*.tar.zst
rm -rf thonny
git clone https://aur.archlinux.org/visual-studio-code-bin.git
su user << EOR
cd visual-studio-code-bin
makepkg
cd ..
EOR
pacman -U --noconfirm visual-studio-code-bin/visual-studio-code-bin*.tar.zst
rm -rf visual-studio-code-bin
git clone https://aur.archlinux.org/libicu50.git
su user << EOR
cd libicu50
makepkg
cd ..
EOR
pacman -U --noconfirm libicu50/libicu50*.tar.zst
rm -rf libicu50
git clone https://aur.archlinux.org/gconf.git
su user << EOR
cd gconf
makepkg
cd ..
EOR
pacman -U --noconfirm gconf/gconf*.tar.zst
rm -rf gconf
git clone https://aur.archlinux.org/icu70.git
su user << EOR
cd icu70
makepkg
cd ..
EOR
pacman -U --noconfirm icu70/icu70*.tar.zst
rm -rf icu70
git clone https://aur.archlinux.org/icu69.git
su user << EOR
cd icu69
makepkg
cd ..
EOR
pacman -U --noconfirm icu69/icu69*.tar.zst
rm -rf icu69
git clone https://aur.archlinux.org/unityhub.git
cd unityhub
makepkg
cd ..
EOR
pacman -U --noconfirm unityhub/unityhub*.tar.zst
rm -rf unityhub
EOF
echo "rebooting"
sleep 3
umount -R /mnt
reboot
