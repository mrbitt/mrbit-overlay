# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/fishsupper/fishsupper-0.1.6.ebuild,v 1.5 2013/02/07 22:04:38 ulm Exp $

EAPI=2
inherit eutils

DESCRIPTION="Burn images to SD cards & USB drives, safe & easy."
HOMEPAGE="http://www.etcher.io"
SRC_URI="${SRC_URI}
	amd64? ( https://github.com/resin-io/etcher/releases/download/v${PV}/Etcher-${PV}-linux-x64.zip ) 
	x86? ( https://github.com/resin-io/etcher/releases/download/v${PV}/Etcher-${PV}-linux-x86.zip )"
	
LICENSE="apache"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
    x11-libs/gtk+:2
	x11-libs/libXi
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXrandr
	x11-libs/libXcomposite
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXtst
	dev-libs/glib:2
	dev-libs/nss
	app-arch/xz-utils"
DEPEND="${RDEPEND}"

RESTRICT="strip"
S=${WORKDIR}

src_prepare() {
	
	local a=x86
	ARCH=$(usex amd64 "x86_64" "i386")
    [ "$ARCH" == "x86_64" ] && a=x64

    sed "s/##AppImage##/Etcher-${PV}-linux-$a.AppImage/g" "${FILESDIR}"/etcher.in > etcher
}

src_install() {
	
	local a=x86
	ARCH=$(usex amd64 "x86_64" "i386")
    [ "$ARCH" == "x86_64" ] && a=x64
	
	dobin ${PN}
	install -D "Etcher-${PV}-linux-$a.AppImage" "${D}/usr/share/etcher/Etcher-${PV}-linux-$a.AppImage"
    install --mode=644 -D "${FILESDIR}/etcher.png" "${D}/usr/share/etcher/etcher.png"
    install -D "${FILESDIR}/Etcher.desktop" "${D}/usr/share/applications/Etcher.desktop"
}
