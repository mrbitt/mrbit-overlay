# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Is a shoot'em up with levels directly editable online"
HOMEPAGE="http://opendesktop.org/content/show.php/Flukz?content=161171"
SRC_URI="http://download.tuxfamily.org/flukz/${PN}${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2 games

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}${PV}
RESTRICT="strip"

src_configure(){
    cd "${S}"
    eqmake4 ${PN}.pro   
}

	
src_install() {
    cd "${S}"
    dodir /usr/{bin,share}
    cp "${S}"/bin/${PN} "${D}"/usr/bin
    #newicon icon.png "${PN}.png"
    make_desktop_entry ${PN} ${PN} ${PN} 
    prepgamesdirs
}
