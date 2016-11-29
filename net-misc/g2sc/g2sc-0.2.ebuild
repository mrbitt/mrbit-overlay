# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Samba gtk2 client"
HOMEPAGE="https://sourceforge.net/projects/g2sc"
SRC_URI="https://sourceforge.net/projects/g2sc/files/g2sc/0.2/g2cs0.2alpha-source.tar.bz2"
    
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gtk+:2
	     net-fs/samba"

S="${WORKDIR}"

src_prepare() {
	 sed -i "${PN}".desktop -e 's:Application;Network:Network:' || die "sed failed"
	sed -i 's/-lsmbclient/-I\/usr\/include\/samba-4.0 -lsmbclient/g' makefile || die "sed failed"
}

src_install() {
  mkdir -p "${D}"/usr/{share/{g2sc,applications},bin}
  install -m644 g2sc.conf "${D}"/usr/share/g2sc
  install -m644 g2sc.png "${D}"/usr/share/g2sc
  install -m755 g2sc "${D}"/usr/bin
  install -m644 g2sc.desktop "${D}"/usr/share/applications
  install -m644 g2sc.desktop "${D}"/usr/share/applications
	 
}
