# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit multilib unpacker

DESCRIPTION="Italian Thesaurus for OpenOffice.org 2and Libreoffice."
HOMEPAGE="http://linguistico.sourceforge.net/wiki/doku.php?id=thesaurus_italiano"
SRC_URI="http://ftp.tku.edu.tw/Linux/LinuxMint/latest/pools/B/pool/main/o/openoffice.org-${PN}/openoffice.org-${PN}_${PV}.gh.deb1-1.1_all.deb"

LICENSE="gpl"
SLOT="0"
KEYWORDS="~amd64 ~i686"
IUSE=""

DEPEND="app-arch/dpkg"
RDEPEND="
	app-office/libreoffice
	"

S=${WORKDIR}

RESTRICT="strip"

src_install() {
        cd "${S}"
	cp -pPR "${S}"/* "${D}"/ || die "copying files failed!"
	#rm -Rd "${D}"DEBIAN || die
}
