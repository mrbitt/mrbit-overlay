# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Graphic conversion utility to create cross stitches"
HOMEPAGE="https://sites.google.com/site/crostiapp/"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${PN}%20${PV}/${P}-source.zip"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=media-libs/fontconfig-2.8.0
    >=media-libs/freetype-2.3.5
    >=dev-libs/glib-2.22.0
    >=sys-libs/zlib-1.1.4
    app-arch/unzip
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}

src_unpack() {
	unzip ${DISTDIR}/${A}
}

src_prepare() {
	#sed -i '41s/qico qsvg/qsvg/g'  ${PN}.pro || die "sed failed"
	qt4-r2_src_prepare
}

src_configure(){
    eqmake4 ${PN}.pro
    make
 }

	
src_install() {
    qt4-r2_src_install
}
