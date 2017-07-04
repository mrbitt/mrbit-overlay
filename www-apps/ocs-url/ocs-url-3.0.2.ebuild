# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="An install helper program for items served on OpenCollaborationServices (OCS). replacing xdgurl"
HOMEPAGE="www.linux-apps.com/p/1136805"
SRC_URI="https://github.com/${PN}/${PN}/archive/release-${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtsvg:5
	dev-qt/qtdeclarative:5
	dev-qt/qtquickcontrols:5
	"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}-release-${PV}

src_compile() {
	cd ${S}
    sh scripts/import.sh
	eqmake5 PREFIX="/usr" ${PN}.pro -r
}

src_install() {
	emake INSTALL_ROOT=${D} install
}
