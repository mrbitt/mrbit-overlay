# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Qt program that will show you detailed listings of all TCP and UDP endpoints on your system, including the local and remote addresses and state of TCP connections"
HOMEPAGE="https://opendesktop.org/content/show.php/QNetStatView?content=157088&PHPSESSID=a14d9a115efc59d8aa9a1502b597dfdc"
SRC_URI="http://dansoft.krasnokamensk.ru/data/1016/${PN}_source.tar.gz"

LICENSE="GPL3"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    media-gfx/imagemagick
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}_source
RESTRICT="strip"

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    eqmake4 ${PN}.pro
}

	
src_install() {
    cd "${S}"
    
    
  
    dodir /usr/bin
    dodir /usr/share/{applications,${PN}}
    dodir /usr/share/icons/hicolor/{16x16/apps,32x32/apps,48x48/apps,64x64/apps,128x128/apps}
    
    cp Bin/${PN} "${D}"/usr/bin/
    cp  Bin/${PN}_ru.qm ${D}/usr/share/${PN}/${PN}_ru.qm
    
    make_desktop_entry  ${PN} ${PN} ${PN}.png
    
    # create and install icons
    for N in 16 32 48 64 128; do convert ${PN}.ico -scale ${N}x${N}! $N.png; done
    
    for N in 16 32 48 64 128; do cp ${S}/${N}.png  ${D}/usr/share/icons/hicolor/${N}x${N}/apps/${PN}.png; done
    
}    
   
