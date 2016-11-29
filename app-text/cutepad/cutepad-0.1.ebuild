# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

MY_PN="CutePad"

DESCRIPTION="A modern text editor based on Qt framework"
HOMEPAGE="http://sourceforge.net/projects/${PN}"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${MY_PN}_Source_Mingw32.zip"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${MY_PN}_Source
#RESTRICT="strip"

src_prepare() {
	cd "${S}"
	find . -type f -exec sed -i 's/addLink/addlink/g' '{}' \;
}

src_install() {
    cd "${S}"
    dodir /usr/{bin,share}
    cp "${S}"/${MY_PN} "${D}"/usr/bin/${PN}
    newicon "${S}/Images/icon.png" "${PN}.png"
    make_desktop_entry ${PN} ${PN} ${PN} Office
}
