# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="Simple desktop clock that is easy to configure"
HOMEPAGE="https://github.com/phobi4n/Simple-Arc-Clock"
SRC_URI="https://github.com/phobi4n/Simple-Arc-Clock/archive/v${PV}.tar.gz  -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	 dev-qt/qtcore:5
	 dev-qt/qtgui:5
	 dev-qt/qtwidgets:5 "
RDEPEND="${DEPEND} "

S="${WORKDIR}/Simple-Arc-Clock-${PV}/"

src_configure() {
	    export QT_SELECT := qt5 
	    lrelease arcclock.pro
        eqmake5  arcclock.pro
}

src_install() {
  dodir /usr/bin
  install -D -m755 ./arcclock "${D}/usr/bin/"
  dodir /usr/share/pixmaps
  install -D -m644 ./arcclock.svg "${D}/usr/share/pixmaps/"
  dodir /usr/share/applications
  install -D -m644 ./arcclock.desktop "${D}/usr/share/applications/"
}
