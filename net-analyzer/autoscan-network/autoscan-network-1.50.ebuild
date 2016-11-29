# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit unpacker eutils

DESCRIPTION="Utility for network exploration with Samba support"
HOMEPAGE="http://autoscan.fr"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="snmp samba nessus trayicon gtk gnome vnc +console sound"
SRC_URI="http://downloads.sourceforge.net/project/autoscan/AutoScan/autoscan-network%201.50/AutoScan-Network-Linux-${PV}.bin.tar.gz"

RDEPEND="net-analyzer/nmap
	gnome? ( >=gnome-base/libgnomeui-2.0
		 >=gnome-base/gnome-keyring-0.4.2 )
	samba? ( net-fs/samba )
	gtk? (  >=x11-libs/gtk+-2.6.0
		>=gnome-extra/gtkhtml-2.0
		>=gnome-base/gnome-vfs-2.8.4
		>=x11-libs/pango-1.8.1 )
	vnc? ( >=net-libs/gtk-vnc-0.2.0 )
	console? ( >=x11-libs/vte-0.11.12 )
	sound? ( >=media-libs/libao-0.8.5
		 >=media-libs/libvorbis-1.1.0 )
	nessus? ( net-analyzer/nessus )
	snmp? ( >=net-analyzer/net-snmp-5.0 )
	>=dev-libs/glib-2.6.3
	dev-libs/elfutils"

DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}"

src_unpack() {
	unpack ${A}
}


src_install() {
      
      #./AutoScan-Network-Linux-${PV}.sh --target "${D}"
      echo -e "\E[0;32m+----------------------------------------+\E[0;0m"
      echo -e "\E[0;32m| Start GentooBuild $NAME-$VERSION |\E[0;0m"
      echo -e "\E[0;32m+----------------------------------------+\E[0;0m"
      
      mkdir -p ${D}/usr/bin
      ( cd ${D}/usr/bin
      ln -s /opt/AutoScan/bin/autoscan-network . )


      mkdir -p ${D}/usr/share/applications
      install -m 644 -p /usr/share/applications/autoscan-network.desktop ${D}/usr/share/applications

      mkdir -p ${D}/opt/AutoScan
      cp -ar /opt/AutoScan/* ${D}/opt/AutoScan
      ( cd ${D} 
      find . | xargs file | grep "executable" | grep ELF | cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null
      find . | xargs file | grep "shared object" | grep ELF | cut -f 1 -d : | xargs strip --strip-unneeded 2> /dev/null
      find . | xargs file | grep "current ar archive" | cut -f 1 -d : | xargs strip -g 2> /dev/null
      )
}
