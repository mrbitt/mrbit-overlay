# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Tool to measure loudspeaker frequency and step response, distortions' SPL and so on"
HOMEPAGE="http://opendesktop.org/content/show.php/QLoud?content=57174"
SRC_URI="http://gaydenko.com/qloud/download/${PN}-${PV}.tar.bz2"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}-${PV}
#RESTRICT="strip"


src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    #kde4-base_src_configure
    #cmake .
    #make 
    eqmake4 ${PN}.pro
    #make clean && make QMAKE=qmake-qt4 PREFIX=/usr
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    emake DESTDIR="${D}" install || die "Install failed!"
    #kde4-base_src_install
    #qt4-r2_src_install
    #dodir /usr/local/bin
    #cp "${S}"/build/hotshots "${D}"/usr/local/bin
#	mkdir -p "${D}"/usr/{bin,share/{pixmaps,applications}}
#	cp release/${PN} "${D}"/usr/bin
#	cp Resources/logo.png "${D}"/usr/share/pixmaps
#	make_desktop_entry ${PN} ${PN} ${PN} "/usr/share/pixmaps/logo.png"
}
