# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib unpacker

DESCRIPTION="With MultiSystem Create LiveUSB simply MultiBoot."
HOMEPAGE="http://liveusb.info/dotclear/"
SRC_URI="http://liveusb.info/multisystem/depot/dists/all/main/binary-amd64/m/${PN}_${PV}_all.deb"

LICENSE="gpl"
SLOT="0"
KEYWORDS="amd64 ~i686"
IUSE=""

DEPEND="app-arch/dpkg"
RDEPEND="
	>=x11-misc/gtkdialog-0.8.3[vte]
	x11-libs/gtk+:2
	app-arch/xz-utils
	sys-fs/mtools
	gnome-base/gvfs
	sys-fs/squashfs-tools
	app-arch/lzma
	sys-fs/dosfstools
	app-arch/cabextract
	net-misc/rsync
	app-shells/bash
	dev-libs/libisofs
	app-arch/unzip
	sys-apps/hdparm
	sys-devel/gettext
	sys-block/parted
	x11-terms/xterm
	x11-libs/gksu
	gnome-extra/zenity
	x11-misc/xdotool
	x11-misc/wmctrl
	app-emulation/qemu
	media-gfx/imagemagick
	sys-boot/syslinux
	sys-boot/grub
	sys-boot/grub-efi
	sys-fs/cryptsetup
	app-cdr/cdrtools
	sys-apps/coreutils
	sys-fs/fatresize
	"

S=${WORKDIR}

RESTRICT="strip"

src_prepare() {
	 sed -i -e "102s|vboxmanage|VBoxManage|g" ${S}/usr/local/share/multisystem/vbox.sh || die "sed failed"
	 sed -i -e "111s|vboxmanage|VBoxManage|g" ${S}/usr/local/share/multisystem/vbox.sh || die "sed failed"
	 sed -i -e '6d' "${S}"/usr/local/share/multisystem/dependances.txt || die "sed failed"
	 sed -i -e '10d' "${S}"/usr/local/share/multisystem/dependances.txt || die "sed failed"
	 sed -i -e '12d' "${S}"/usr/local/share/multisystem/dependances.txt || die "sed failed"
	 sed -i '227,236d' "${S}"/usr/local/share/multisystem/gui_multisystem.sh || die "sed failed"
     sed -i '304,311d' "${S}"/usr/local/share/multisystem/gui-detect.sh || die "sed failed"
     #sed -i "s|multisystem-mountpoint-usb|multisystem-detection-usb|g" "${S}"/usr/local/share/multisystem/gui-detect.sh || die "sed failed"
}

src_install() {
        cd "${S}"
	cp -pPR "${S}"/* "${D}"/ || die "copying files failed!"
	chmod 0755 "${D}"/usr/local/share/multisystem/lang_list.txt
	chmod 0755 "${D}"/usr/local/share/multisystem/locale/cs/LC_MESSAGES/multisystem.cs.po
}

pkg_postinst() {
	
	elog "sudo gpasswd -a <USER> adm"
	elog " 	15 sudo nano /etc/sudoers
	        16 # User privilege specification
			17 root    ALL=(ALL) ALL
			18 <USER>  ALL=(ALL) ALL
			19 # Allow members of group sudo to execute any command
			20 # (Note that later entries override this, so you might need to move
			21 # it further down)
			22 %sudo ALL=(ALL) ALL"
}
