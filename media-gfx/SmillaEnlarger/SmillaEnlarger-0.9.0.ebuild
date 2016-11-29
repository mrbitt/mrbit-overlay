# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Small graphical tool (based on Qt) to resize, especially magnify bitmaps in high quality."
HOMEPAGE="http://sourceforge.net/projects/imageenlarger/"
SRC_URI="http://downloads.sourceforge.net/project/imageenlarger/imageenlarger/${PN}%20Release%20${PV}/${PN}_${PV}_source.zip"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}_${PV}_source/${PN}Src/

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    #kde4-base_src_configure
    eqmake4 ImageEnlarger.pro
}

src_install() {
    cd "${S}"/build 
    echo "${WORKDIR}"
    #kde4-base_src_install
    #qt4-r2_src_install
    dodir /usr/bin
    dodir /usr/share/{pixmaps,applications}
    cp "${S}"/${PN} "${D}"/usr/bin
    #cp "${S}"/smilla.png  "${D}"/usr/share/pixmaps/
    doicon "${S}"/smilla.png || die "doicon failed"
    make_desktop_entry ${PN} imageenlarger smilla Graphics
}
