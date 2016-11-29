# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit  eutils kde4-base qt4-r2

DESCRIPTION="A powerful general purpose wallpaper changer"
HOMEPAGE="http://melloristudio.com/"
SRC_URI="http://sourceforge.net/projects/wall-changer/files/${PN}_${PV}.tar.gz"

IUSE="kup rsync"
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtcore:4
	dev-libs/libunity
	x11-libs/libnotify
	media-libs/opencv
	media-libs/libexif
	x11-libs/bamf
	dev-libs/libappindicator"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_configure(){
    eqmake4 ${PN}.pro
    #make clean && make QMAKE=qmake-qt4
    #./configure.sh --prefix=/usr && make QMAKE=qmake-qt4
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

src_install() {
    dodir /usr/{bin,share}
    #dodir /usr/share/{applications,knotter,doc}
    cp "${S}"/${PN} "${D}"/usr/bin
    #newicon icon.png "${PN}.png"
    make_desktop_entry ${PN} ${PN} ${PN} 
    #cp "${S}"/${PN}.desktop "${D}"usr/share/applications
    #cp -pPR "${S}"/data/* "${D}"usr/share/knotter/
    #cp -pPR "${S}"/man "${D}"usr/share
    #cp -pPR "${S}"/doc "${D}"usr/share
    #rm -R "${D}"var || die
    #prepgamesdirs
}