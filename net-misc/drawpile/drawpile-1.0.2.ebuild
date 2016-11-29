# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils 

DESCRIPTION="Networking-collaborative drawing program drawing (whiteboarding) program"
HOMEPAGE="http://drawpile.net/"
SRC_URI="http://drawpile.net/files/src/${P}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="client server systemd"

REQUIRED_USE="|| ( client server )"

DEPEND="dev-qt/qtcore:5
		dev-qt/qtnetwork:5
		kde-frameworks/karchive:5
		client? ( dev-qt/qtgui:5 )"

RDEPEND="${DEPEND}
             systemd? ( sys-apps/systemd ) "

src_prepare() {
	        #For Token error include...
	    sed -i '31,1i#include <QtCore/QIODevice>' src/shared/bundled/karchive/karchive_bundled.h || die
	    sed -i desktop/${PN}.desktop -e 's:x-scheme-handler/drawpile:x-scheme-handler/drawpile;:' || die
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use client CLIENT)
		$(cmake-utils_use server SERVER)
	)

	cmake-utils_src_configure
}


src_install() {
	#emake INSTALL_ROOT="${D}" ninja -C 'build' install 

	cmake-utils_src_install

	dodir /usr/share/{applications,appdata}
	dodir /usr/share/icons/hicolor/{16x16/apps,32x32/apps,64x64/apps,128x128/apps,256x256/apps}
	for N in 16 32 64 128 256; do cp desktop/${PN}-${N}x${N}.png  ${D}/usr/share/icons/hicolor/${N}x${N}/apps/${PN}.png; done
	newicon desktop/${PN}.ico ${PN}.ico
	cp desktop/${PN}.desktop  ${D}/usr/share/applications/
	cp desktop/${PN}.appdata.xml ${D}/usr/share/appdata/
}
