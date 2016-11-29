# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils qmake-utils 

DESCRIPTION="File Manager based on Qt4/5"
HOMEPAGE="https://github.com/marcusbritanicus/NewBreeze"
SRC_URI="https://github.com/marcusbritanicus/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 +qt5 "

DEPEND="qt4? (
		dev-qt/qtcore:4=
		dev-qt/qtgui:4=
		dev-qt/qtscript:4=
		>=dev-qt/qtwebkit-4.8:4
	)
	qt5? (
		dev-qt/qtcore:5=
		dev-qt/qtgui:5=
		dev-qt/qtnetwork:5=
		dev-qt/qtscript:5=
		dev-qt/qtwidgets:5=
		dev-qt/qtwebkit:5
	)
"
RDEPEND="${DEPEND}
	dev-python/pyqwt
	sys-libs/zlib
	dev-libs/libtar
	dev-libs/libzip
	app-arch/bzip2
	app-arch/lzma
	"
S=${WORKDIR}/${P}

src_prepare() {
	        #For Linker libs...
	    sed -i Core/FileIO/NBFileIO.cpp -e 's:O_CREAT:O_CREAT, 0660:' || die
	    sed -i newbreeze.desktop -e 's:FileTools:FileTools;:' || die
	    sed -i ${PN}.pro -e 's:$PREFIX/include:$$PREFIX/include:' || die
}

src_configure() {

 	if use qt4 ; then
		eqmake4 
	else
		eqmake5
	fi
}


src_install() {
	emake INSTALL_ROOT="${D}" INSTALL_DIR="${D}" install
	einstalldocs
}
