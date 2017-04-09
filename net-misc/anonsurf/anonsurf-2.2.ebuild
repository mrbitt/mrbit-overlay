# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pencil/pencil-0.4.4_beta.ebuild,v 1.4 2013/03/02 21:38:40 hwoarang Exp $

EAPI=5
inherit eutils fdo-mime unpacker

#MY_P=${P/_beta/b}

DESCRIPTION="Anonymizaton toolkit"
HOMEPAGE="github.com/ParrotSec/anonsurf"
SRC_URI="https://github.com/ParrotSec/${PN}/raw/master/${PN}_${PV}%2Bparrot1_all.deb -> ${P}_all.deb"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="net-firewall/iptables
	net-vpn/tor
	net-vpn/i2p"
DEPEND="${RDEPEND}
	app-arch/unzip
	app-arch/dpkg"

S=${WORKDIR}

src_prepare() {
#	#epatch "${FILESDIR}"/${P}-gcc461.patch
	#sed -i s|iceweasel|"python -mwebbrowser"|g ${S}/usr/bin/anonsurf || die
	sed -i "88s|iceweasel|python -mwebbrowser|g" ${S}/usr/bin/anonsurf || die
	sed -i "138s|systemctl start tor|/etc/init.d/tor start|g" ${S}/usr/bin/anonsurf || die
}

src_install() {
	
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
	dodir /usr/lib64
	rm -rf ${D}/etc/anonsurf/torrc || die
}
pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	
	set -e
    
    if [ -e /etc/tor/torrc ]; then
       mv /etc/tor/torrc /etc/tor/torrc.orig
    fi
    
    if [ -e /etc/anonsurf/torrc ]; then
      cp /etc/anonsurf/torrc /etc/tor/torrc
    fi
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	
	set -e
	
	if [ -e /etc/tor/torrc.orig ]; then
      mv /etc/tor/torrc.orig /etc/tor/torrc
    fi

}
