# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="A simple music quiz game"
HOMEPAGE="www.linux-apps.com/p/1109384/"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1494541345/${PN}-v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="debug qt4 +qt5"

RDEPEND="
	qt4? ( dev-qt/qtcore:4
			 dev-qt/qtgui:4
			 dev-qt/qt3support:4 )
	qt5? ( dev-qt/qtcore:5
	       dev-qt/qtgui:5
	       dev-qt/qtwidgets:5 )
	media-libs/taglib
	media-libs/phonon
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-v${PV}

src_compile() {
	 #cd build
	if use qt4 ; then
	     eqmake4
		 emake || die
	else
	    eqmake5 
	    emake || die
	fi
	   lrelease Auralquiz.pro
}

src_install() {
	sed -i -e 's|INSTALL_ROOT)/usr/games/|INSTALL_ROOT)/usr/games/bin/|g' Makefile || die
    emake INSTALL_ROOT="${D}" exec_prefix="${EPREFIX}/usr/games/bin" install || die
}
