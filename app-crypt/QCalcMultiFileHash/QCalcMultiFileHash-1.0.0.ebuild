# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PLOCALES="en ru"

inherit eutils qmake-utils fdo-mime l10n 

DESCRIPTION="Another calculator hash (SHA1, SHA-224, SHA-256, SHA-384, SHA-512, MD5, CRC32, CRC8)"
HOMEPAGE="https://bitbucket.org/admsasha/qcalcmultifilehash"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1502672123/${PN}.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	 dev-qt/qtcore:5
	 dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_compile() {
	    eqmake5 
	    emake || die
}

src_install() {
    dobin Bin/qcalcmultifilehash
    newicon ${PN}.ico qcalcmultifilehash.png
						#"executable"  "Titol"  "icon name"  "Categoty"
	make_desktop_entry "qcalcmultifilehash" "Another calculator hash" "qcalcmultifilehash" "System;Security;"
    
    insinto /usr/share/qcalcmultifilehash
	doins  qcalcmultifilehash_*.ts
}

pkg_postinst(){
	fdo-mime_desktop_database_update
}

pkg_postrm(){
	fdo-mime_desktop_database_update
}
