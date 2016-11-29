# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_MIN_CLONE_TYPE=mirror
EGIT_REPO_URI="git://github.com/pbek/QOwnNotes.git"
inherit eutils git-r3 qmake-utils

DESCRIPTION="Open source notepad with Owncloud support"
HOMEPAGE="http://www.qownnotes.org"
SRC_URI=""

IUSE="qt5"
REQUIRED_USE="qt5"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
S="${WORKDIR}/${PN}-9999"

RDEPEND="
    dev-qt/qtdeclarative:5
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtsql:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5 "
DEPEND="${RDEPEND}
         dev-libs/openssl"

DOCS=( CHANGELOG.md README.md SHORTCUTS.md )

src_configure() {
	sed -i "10s|Todo|Office|g" src/QOwnNotes.desktop || die "sed failed"
	eqmake5 src/QOwnNotes.pro -r
}

src_install() {
	cd src
	dobin ../QOwnNotes
	
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
				
	cd .. && einstalldocs
	
}
