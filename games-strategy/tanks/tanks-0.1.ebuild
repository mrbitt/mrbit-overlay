# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="qt/c++ game tank"
HOMEPAGE="http://sourceforge.net/projects/battleoftanks"
SRC_URI="http://sourceforge.net/projects/battleoftanks/files/${P}/${P}-src.zip"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2 games

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${P}-src
RESTRICT="strip"

src_configure(){
    cd "${S}"
    eqmake4 ${PN}.pro   
}

	
src_install() {
    cd "${S}"
    dodir /usr/{bin,share}
    cp "${S}"/${PN} "${D}"/usr/bin
    #newicon icon.png "${PN}.png"
    make_desktop_entry ${PN} ${PN} ${PN} 
    prepgamesdirs
}
