# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Is a front end for utilities network for kommander"
HOMEPAGE="http://opendesktop.org/content/show.php/wiKonf?content=88826"
SRC_URI="http://www.sya54m.eu/getfile.php?nome=file//${P}.tar.bz2"

IUSE=""
LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="kde-base/kommander"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

src_prepare() {
        cd "${S}"
	sed -i -e 's|$(PREFIX)/doc|$(PREFIX)/share/doc|g' "${S}/Makefile" || die
	sed -i -e 's|Categories=Settings;Network|Categories=Settings;Network;|g' "${S}/wiKonf.desktop" || die
	sed -i -e 's|Exec=kmdr-executor|kdesu kommander|g' "${S}/wiKonf.desktop" || die
}

src_configure(){
      make
}

src_install() {
   cd "${S}"
   make DESTDIR="${D}" install || die "Install failed!"
}