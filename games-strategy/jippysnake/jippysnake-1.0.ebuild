# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils games

DESCRIPTION="Is an advanced snake game with 150 levels and 9 extra levels."
HOMEPAGE="http://opendesktop.org/content/show.php/Jippy+Snake+8?content=174352"
SRC_URI="https://github.com/Blahord/${PN}8/archive/${PV}-rc.1.tar.gz -> ${P}.tar.gz"

SLOT="0"
LICENSE="GPL-3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+qt5"

RDEPEND="       dev-qt/qtcore:5=
		dev-qt/qtgui:5=
		dev-qt/qtxml:5=
		dev-qt/qtopengl:5=
		dev-qt/qtmultimediat:5=
		dev-qt/qtwidgets:5="
DEPEND="${RDEPEND}
                media-libs/freealut"

S="${WORKDIR}"/${PN}8-${PV}-rc.1

src_compile() {
	cmake . && make
}

src_install() {
    prepgamesdirs
    dodir /usr/{bin,share}
    cp js8 "${D}"/usr/bin
    newicon "logo/png/logp_32.png ${PN}.png"
    make_desktop_entry ${PN} ${PN} ${PN} 
}