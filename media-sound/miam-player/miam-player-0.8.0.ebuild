# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils qmake-utils

DESCRIPTION="Cross-platform open source music player built with Qt5, QTav and Taglib."
HOMEPAGE="http://opendesktop.org/content/show.php/Miam-Player?content=169649"

SRC_URI="https://github.com/MBach/Miam-Player/archive/v${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/Miam-Player-${PV}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+qt5"

DEPEND="qt5? (
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtcore:5
		dev-qt/qtmultimedia:5
		dev-qt/qtx11extras:5
	)"
RDEPEND="${DEPEND}
         dev-libs/openssl
         media-video/qtav"

DOCS=( LICENSE README.md )
         
src_compile() {
	eqmake5 ${PN}.pro -r
}

src_install() {
        emake INSTALL_ROOT="${D}" install || die
	#install -Dm644 debian/usr/share/icons/hicolor/64x64/apps/application-x-miamplayer.png ${D}/usr/share/pixmaps/${PN}.png 
	#make_desktop_entry ${PN} ${PN} ${PN} Audio
	sed -i ${D}/usr/share/applications/${PN}.desktop -e 's:Previous;Next:Previous;Next;:' || die
	einstalldocs
}
