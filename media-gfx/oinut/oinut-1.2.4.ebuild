# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils qmake-utils

DESCRIPTION="Free and open source (GPLv3) animation software for Linux"
HOMEPAGE="http://opendesktop.org/content/show.php/Oinut?content=174028"
SRC_URI="https://github.com/purplehuman/oinut/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="+kde5"

DEPEND=">=dev-qt/qtcore-5.2
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtmultimedia:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5
	media-libs/opencv"
RDEPEND="${DEPEND}
	dev-libs/quazip[qt5]
	sys-libs/zlib
        media-gfx/sane-backends"
S=${WORKDIR}/${P}

src_prepare() {
	        #For Linker libs...
	    sed -i ${PN}.pro -e 's:-lopencv_highgui:-lopencv_highgui -lopencv_videoio:' || die
	    sed -i ${PN}.pro -e 's:-lquazip-qt5:-lquazip:' || die
	        #For Gentoo system   
	    sed -i resource/${PN}.desktop -e 's:Graphics:Graphics;:' || die
	    sed -i resource/${PN}.desktop -e 's:x-oin:x-oin;:' || die
}

src_compile() {
	cd ${P}
	eqmake5 ${PN}.pro
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	dodoc CHANGELOG LICENSE README AUTHORS
}