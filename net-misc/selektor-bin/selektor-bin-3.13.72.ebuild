# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit versionator

#_minor=47

MY_P=$(version_format_string '${PN/-bin}-$1.$2.$3_all')

DESCRIPTION="Tor launcher and exit node chooser"
HOMEPAGE="http://www.dazzleships.net/?page_id=71"
#SRC_URI="http://www.dazzleships.net/?wpdmact=process&did=My5ob3RsaW5r -> ${P}-${_minor}_all.tar.gz"
SRC_URI="http://www.dazzleships.net/?wpdmact=process&did=My5ob3RsaW5r -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

KEYWORDS="amd64 x86"

RDEPEND="net-vpn/tor
        dev-java/proguard"
DEPEND="${RDEPEND}"

#S="${WORKDIR}/${PN}_${PV}-${_minor}_all"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	 cd "${S}"
	sed -i 's|Keywords=network;tor|Keywords=network;tor;|g' ${S}/applications/selektor-autostart.desktop  || die
	sed -i 's|Application;|Network;|g' ${S}/applications/selektor-autostart.desktop  || die
	
	sed -i 's|Keywords=network;tor|Keywords=network;tor;|g' ${S}/applications/selektor.desktop  || die
	sed -i 's|Categories=Network;Application;|Categories=Network;|g' ${S}/applications/selektor.desktop  || die
	
	sed -i 's|Keywords=network;tor|Keywords=network;tor;|g' ${S}/applications/selektor-proxy-reset.desktop  || die
	sed -i 's|Categories=Network;Application;|Categories=Network;|g' ${S}/applications/selektor-proxy-reset.desktop  || die
}


src_configure(){
       cd "${S}"
}

src_install() {
    cd "${S}"
    dodir /usr/{bin,share}
    #dodir /etc/xdg/autostart
    dodir /opt
    #cp applications/selektor-autostart.desktop "${D}"/etc/xdg/autostart -f || die
    cp opt "${D}" -rf
    cp applications man "${D}/usr/share" -rf
    cp "${PN/-bin}" "${D}/usr/bin" -rf
}
