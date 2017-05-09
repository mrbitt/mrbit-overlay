

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils qmake-utils

DESCRIPTION="OwnNotes is a plain-text notepad, that (optionally) works together with the notes application of ownCloud."
HOMEPAGE="http://opendesktop.org/content/show.php/QOwnNotes?content=170846"
MY_P="b2924-160743"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/src/${PN}-${PV}.tar.xz"
#SRC_URI="https://github.com/pbek/QOwnNotes/archive/linux-${MY_P}.tar.gz -> ${P}.tar.gz"
#S="${WORKDIR}/QOwnNotes-linux-${MY_P}/src"
S="${WORKDIR}/${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="qt5"
REQUIRED_USE="qt5"

DEPEND="
		dev-qt/qtdeclarative:5
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtcore:5
		dev-qt/qtsql:5
		dev-qt/qtsvg:5
		dev-qt/qtnetwork:5
		dev-qt/qtscript:5
		dev-qt/qtxml:5
		dev-qt/qtprintsupport:5 "
RDEPEND="${DEPEND}
         dev-libs/openssl"

DOCS=( CHANGELOG.md README.md SHORTCUTS.md )

src_prepare() {
	echo "#define RELEASE \"Gentoo\"" > release.h
}
         
src_compile() {
	sed -i "10s|Todo|Office|g" QOwnNotes.desktop || die "sed failed"
	eqmake5 QOwnNotes.pro -r
}

src_install() {
	emake
	dobin QOwnNotes

	dodir /usr/share/{applications,QOwnNotes}
	dodir /usr/share/QOwnNotes/languages
	
	insinto /usr/share/QOwnNotes/languages
	doins languages/*.qm

	dodir /usr/share/icons/hicolor/{16x16/apps,24x24/apps,32x32/apps,48x48/apps,64x64/apps,96x96/apps,128x128/apps,256x256/apps,512x512/apps}
	for N in 16 24 32 48 64 96 128 256 512; do cp images/icons/${N}x${N}/apps/QOwnNotes.png  ${D}/usr/share/icons/hicolor/${N}x${N}/apps/QOwnNotes; done
	
	doicon -s scalable "images/icons/scalable/apps/QOwnNotes.svg"
    
    insinto /usr/share/applications
	doicon -s 128 images/icons/128x128/apps/QOwnNotes.png
	doicon -s scalable images/icons/scalable/apps/QOwnNotes.svg
	doins QOwnNotes.desktop
    
    #cp QOwnNotes.desktop  ${D}/usr/share/applications/
	#newicon  QOwnNotes.ico QOwnNotes.ico
	
	#newicon ../icons/icon.svg QOwnNotes.svg
	#newicon ../icons/icon.png QOwnNotes.png

	#make_desktop_entry QOwnNotes QOwnNotes QOwnNotes Office
	einstalldocs
}
