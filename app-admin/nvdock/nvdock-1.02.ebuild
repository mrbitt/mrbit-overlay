# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="A tray icon for easy launching of the NVIDIA control panel"
HOMEPAGE="http://www.opsat.net/user/bob/projects/nvdock"
#SRC_URI="http://ftp1.fr.freebsd.org/pub/frugalware/frugalware-stable/source/xapps-extra/${PN}/${P}.tar.bz2"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/bobmajdakjr/${P}.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/gtk+:2"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_prepare() {
	default
	epatch "${FILESDIR}"/fix-build.patch
}

src_compile() {
	    emake || die
}

src_install() {
	
  install -D -m755 build/nvdock "${D}/usr/bin/nvdock"
  install -D -m644 data/nvdock.png "${D}/usr/share/pixmaps/nvdock.png"
  install -D -m644 data/nvdock.desktop "${D}/usr/share/applications/nvdock.desktop"
  dodoc COPYING
}
