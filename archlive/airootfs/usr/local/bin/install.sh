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
pacstrap -K /mnt base linux linux-firmware networkmanager nano man-db e2fsprogs ntfs-3g dosfstools grub efibootmgr intel-ucode amd-ucode os-prober
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
mkdir -p /home/admin
useradd -d /home/admin -G users,video,audio,wheel admin
useradd -d /home/user -G users,video,audio user
echo "user:user" | chpasswd
echo "admin:admin" | chpasswd
chown admin /home/admin
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
pacman -S --noconfirm libreoffice-fresh krusader ranger btop neovim thunderbird firefox geogebra neovim blueman freecad blender gimp krita git base-devel sudo esptool hicolor-icon-theme mypy python-asttokens python-docutils python-jedi python-pillow python-pip python-ptyprocess python-pylint python-send2trash python-setuptools python-wheel python-build python-installer tk python-numpy python-pygame python-cached-property python python-django python-pytest python-humanize python-littleutils python-sqlalchemy python-setuptools-scm python-beautifulsoup4 python-flask python-markupsafe python-pandas geckodriver python-requests python-certifi python-debugpy python-importlib-metadata python-inflection python-multidict python-urllib3 alsa-lib gcc-libs glibc gnupg gtk3 libnotify libsecret libxkbfile libxss lsof nss shared-mime-info glib2 libdbusmenu-glib gnome-keyring cpio openssl-1.1 libappindicator-gtk3 clang make sh patch dbus-glib libldap libxml2 polkit gnome-common gobject-introspection gtk-doc intltool nemo go python-exceptiongroup python-trio python-wsproto xorg-drivers xorg xorg-apps appstream-glib archlinux-appstream-data desktop-file-utils gnutls json-glib libhandy vte3 asciidoc gettext itstool meson ninja vala xorgproto lxsession polkit-gnome libsoup3 libusb libusb-compat python-pyserial usbutils freetype2 libxrender libxtst which gtk2 libglvnd libpng zlib libxft tcl gumbo-parser libjpeg-turbo libtiff tcllib maven jre17-openjdk xdg-utils npm nodejs-lts-fermium snappy re2 minizip libxslt libevent ffmpeg c-ares kde-cli-tools trash-cli xdg-desktop-portal util-linux fuse2
git clone https://aur.archlinux.org/yay-bin.git
chown admin yay-bin
su admin << EOR
cd yay-bin
makepkg
cd ..
EOR
pacman -U --noconfirm yay-bin/yay-bin*.tar.zst
rm -rf yay-bin
cat >> /etc/sudoers << EOR
root ALL=(ALL:ALL) ALL
%wheel ALL=(ALL:ALL) NOPASSWD: ALL
@includedir /etc/sudoers.d
EOR
git clone https://aur.archlinux.org/python-trio-websocket.git
chown admin python-trio-websocket
su admin << EOR
cd python-trio-websocket
makepkg
cd ..
EOR
pacman -U --noconfirm python-trio-websocket/python-trio-websocket*.tar.zst
rm -rf python-trio-websocket
git clone https://aur.archlinux.org/python-outdated.git
chown admin python-outdated
su admin << EOR
cd python-outdated
makepkg
cd ..
EOR
pacman -U --noconfirm python-outdated/python-outdated*.tar.zst
rm -rf python-outdated
git clone https://aur.archlinux.org/python-cheap_repr.git
chown admin python-cheap_repr
su admin << EOR
cd python-cheap_repr
makepkg
cd ..
EOR
pacman -U --noconfirm python-cheap_repr/python-cheap_repr*.tar.zst
rm -rf python-cheap_repr
git clone https://aur.archlinux.org/python-flask-humanize.git
chown admin python-flask-humanize
su admin << EOR
cd python-flask-humanize
makepkg
cd ..
EOR
pacman -U --noconfirm python-flask-humanize/python-flask-humanize*.tar.zst
rm -rf python-flask-humanize
git clone https://aur.archlinux.org/python-pgzero.git
chown admin python-pgzero
su admin << EOR
cd python-pgzero
makepkg
cd ..
EOR
pacman -U --noconfirm python-pgzero/python-pgzero*.tar.zst
rm -rf python-pgzero
git clone https://aur.archlinux.org/python-selenium.git
chown admin python-selenium
su admin << EOR
cd python-selenium
makepkg
cd ..
EOR
pacman -U --noconfirm python-selenium/python-selenium*.tar.zst
rm -rf python-selenium
git clone https://aur.archlinux.org/python-birdseye.git
chown admin python-birdseye
su admin << EOR
cd python-birdseye
makepkg
cd ..
EOR
pacman -U --noconfirm python-birdseye/python-birdseye*.tar.zst
rm -rf python-birdseye
git clone https://aur.archlinux.org/thonny.git
chown admin thonny
su admin << EOR
cd thonny
makepkg
cd ..
EOR
pacman -U --noconfirm thonny/thonny*.tar.zst
rm -rf thonny
git clone https://aur.archlinux.org/visual-studio-code-bin.git
chown admin visual-studio-code-bin
su admin << EOR
cd visual-studio-code-bin
makepkg
cd ..
EOR
pacman -U --noconfirm visual-studio-code-bin/visual-studio-code-bin*.tar.zst
rm -rf visual-studio-code-bin
git clone https://aur.archlinux.org/libicu50.git
chown admin libicu50
su admin << EOR
cd libicu50
makepkg
cd ..
EOR
pacman -U --noconfirm libicu50/libicu50*.tar.zst
rm -rf libicu50
git clone https://aur.archlinux.org/gconf.git
chown admin gconf
su admin << EOR
cd gconf
makepkg
cd ..
EOR
pacman -U --noconfirm gconf/gconf*.tar.zst
rm -rf gconf
git clone https://aur.archlinux.org/icu70.git
chown admin icu70
su admin << EOR
cd icu70
makepkg
cd ..
EOR
pacman -U --noconfirm icu70/icu70*.tar.zst
rm -rf icu70
git clone https://aur.archlinux.org/icu69-bin.git
chown admin icu69-bin
su admin << EOR
cd icu69-bin
makepkg
cd ..
EOR
pacman -U --noconfirm icu69-bin/icu69-bin*.tar.zst
rm -rf icu69-bin
git clone https://aur.archlinux.org/unityhub.git
chown admin unityhub
su admin << EOR
cd unityhub
makepkg
cd ..
EOR
pacman -U --noconfirm unityhub/unityhub*.tar.zst
rm -rf unityhub
git clone https://aur.archlinux.org/libpamac-aur.git
chown admin libpamac-aur
su admin << EOR
cd libpamac-aur
makepkg
cd ..
EOR
pacman -U --noconfirm libpamac-aur/libpamac-aur*.tar.zst
rm -rf libpamac-aur
git clone https://aur.archlinux.org/pamac-aur.git
chown admin pamac-aur
su admin << EOR
cd pamac-aur
makepkg
cd ..
EOR
pacman -U --noconfirm pamac-aur/pamac-aur*.tar.zst
rm -rf pamac-aur
git clone https://aur.archlinux.org/arduino-ide-bin.git
chown admin arduino-ide-bin
su admin << EOR
cd arduino-ide-bin
makepkg
cd ..
EOR
pacman -U --noconfirm arduino-ide-bin/arduino-ide-bin*.tar.zst
rm -rf arduino-ide-bin
git clone https://aur.archlinux.org/ncurses5-compat-libs.git
chown admin ncurses5-compat-libs
su admin << EOR
cd ncurses5-compat-libs
makepkg
cd ..
EOR
pacman -U --noconfirm ncurses5-compat-libs/ncurses5-compat-libs*.tar.zst
rm -rf ncurses5-compat-libs
git clone https://aur.archlinux.org/android-studio.git
chown admin android-studio
su admin << EOR
cd android-studio
makepkg
cd ..
EOR
pacman -U --noconfirm android-studio/android-studio*.tar.zst
rm -rf android-studio
git clone https://aur.archlinux.org/sublime-text-4.git
chown admin sublime-text-4
su admin << EOR
cd sublime-text-4
makepkg
cd ..
EOR
pacman -U --noconfirm sublime-text-4/sublime-text-4*.tar.zst
rm -rf sublime-text-4
git clone https://aur.archlinux.org/snack.git
chown admin snack
su admin << EOR
cd snack
makepkg
cd ..
EOR
pacman -U --noconfirm snack/snack*.tar.zst
rm -rf snack
git clone https://aur.archlinux.org/tkimg.git
chown admin tkimg
su admin << EOR
cd tkimg
makepkg
cd ..
EOR
pacman -U --noconfirm tkimg/tkimg*.tar.zst
rm -rf tkimg
git clone https://aur.archlinux.org/jerry.git
chown admin jerry
su admin << EOR
cd jerry
makepkg
cd ..
EOR
pacman -U --noconfirm jerry/jerry*.tar.zst
rm -rf jerry
git clone https://aur.archlinux.org/stockfish.git
chown admin stockfish
su admin << EOR
cd stockfish
makepkg
cd ..
EOR
pacman -U --noconfirm stockfish/stockfish*.tar.zst
rm -rf stockfish
pacman -Rsu gnome-software
git clone https://aur.archlinux.org/electron13-bin.git
chown admin electron13-bin
su admin << EOR
cd electron13-bin
makepkg
cd ..
EOR
pacman -U --noconfirm electron13-bin/electron13-bin*.tar.zst
rm -rf electron13-bin
git clone https://aur.archlinux.org/scratch3.git
chown admin scratch3
su admin << EOR
cd scratch3
makepkg scratch3
cd ..
EOR
pacman -U --noconfirm scratch3/scratch3*.tar.zst
rm -rf scratch3
git clone https://aur.archlinux.org/cura-bin.git
chown admin cura-bin
su admin << EOR
cd cura-bin
makepkg
cd ..
EOR
pacman -U --noconfirm cura-bin/cura-bin*.tar.zst
rm -rf cura-bin
EOF
echo "rebooting"
sleep 3
umount -R /mnt
reboot

