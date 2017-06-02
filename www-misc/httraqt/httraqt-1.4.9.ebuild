# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit eutils l10n cmake-utils

#MY_P=${PN}-${PV}

DESCRIPTION="Graphical user interface for HTTrack library, developed in C++ and based on Qt4"
HOMEPAGE="http://httraqt.sourceforge.net"

#RESTRICT="mirror"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="qt4 +qt5"

DEPEND=">=www-client/httrack-3.45.4
    qt4? (
		dev-qt/qtgui:4
             )
    qt5? (
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
             ) "
	
RDEPEND="${DEPEND}"

CMAKE_VERBOSE="OFF"

pre_src_configure() {
	for f in "${FILESDIR}"/*.patch; do {
		epatch "${f}"
	} done
     sed -i "9s|httraqt.xpm|httraqt|g" "${S}"/desktop/httraqt.desktop || die "sed failed"
}

src_unpack() {
	unpack ${A}
	cd ${WORKDIR}
	mv ${PN} ${P}
}

src_configure() {
        if use !qt4 ; then
           sed -i "9s|USE_QT_VERSION 4|USE_QT_VERSION 5|g" CMakeLists.txt || die "sed failed"
        fi
        
	if use qt4 || use qt5 ; then
		mycmakeargs+=(
			-DBUILD_QtDialog=ON
			$(cmake-utils_use_find_package qt5 Qt5Widgets)
		)
	 #sed -i "9s|USE_QT_VERSION 4|USE_QT_VERSION 5|g" CMakeLists.txt || die "sed failed"
	fi
        
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	chmod 755 ${D}/usr/bin/httraqt
	newicon icons/hicolor/32x32/apps/${PN}.png  ${PN}.png||  die "doicons failed!"
}
