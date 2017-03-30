# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit versionator

#_minor=47

MY_P=$(version_format_string '${PN}_$1.$2-$3_all')

DESCRIPTION="Tor launcher and exit node chooser"
HOMEPAGE="http://www.dazzleships.net/?page_id=71"
#SRC_URI="http://www.dazzleships.net/?wpdmact=process&did=My5ob3RsaW5r -> ${P}-${_minor}_all.tar.gz"
SRC_URI="http://www.dazzleships.net/?wpdmact=process&did=My5ob3RsaW5r -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

KEYWORDS="amd64 x86"

RDEPEND="net-vpn/tor"
DEPEND="${RDEPEND}"

#S="${WORKDIR}/${PN}_${PV}-${_minor}_all"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	 cd "${S}"
}


src_configure(){
       cd "${S}"
}

src_install() {
    cd "${S}"
    dodir /usr/bin
    dodir /usr/share
    #dodir /etc/xdg/autostart
    dodir /opt
    #cp applications/selektor-autostart.desktop "${D}"/etc/xdg/autostart -f || die
    cp opt "${D}" -rf
    cp applications man "${D}/usr/share" -rf
    cp "${PN}" "${D}/usr/bin" -rf
}
