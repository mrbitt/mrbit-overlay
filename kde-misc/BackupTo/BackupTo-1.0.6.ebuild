# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $ ebuild by mrbit --> giacomogiorgianni@gmail.com

EAPI=5

inherit qt4-r2 qmake-utils

MY_PV=${PV}-stable

DESCRIPTION="QT-utility for backup easy and fast."
HOMEPAGE="http://opendesktop.org/content/show.php/BackupTo?content=149622"
SRC_URI="http://opendesktop.org/CONTENT/content-files/149622-${PN}.zip"
RESTRICT="mirror"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}
RESTRICT="strip"


src_install() {
    dodir /usr/{bin,share}
    cp ${PN} "${D}"/usr/bin
    doicon ${PN}.png || die "doicon failed"
    make_desktop_entry ${PN} ${PN} ${PN} System;
}