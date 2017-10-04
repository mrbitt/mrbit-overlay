# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils qmake-utils
DESCRIPTION="OCS-compatible Electron-based frontend"
HOMEPAGE="www.opendesktop.org/s/Linux-Apps/p/1175480/"
SRC_URI="https://github.com/opendesktop/ocsstore/archive/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtwebsockets:5
	net-libs/nodejs
	"
DEPEND="${RDEPEND}"

S=${WORKDIR}/ocsstore-release-${PV}
	
src_compile() {
	cd ${S}
	#append-cxxflags -std=c++11
	eqmake5 
	make clean && make 
}

src_install() {
	cd ${S}
	make DESTDIR="${D}" prefix="/usr" install
}
