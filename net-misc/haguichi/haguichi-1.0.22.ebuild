# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Interfaz grafica para Logmein Hamachi"
HOMEPAGE="http://haguichi.net"
SRC_URI="https://launchpad.net/haguichi/1.0/${PV}/+download/${PN}-${PV}-clr4.0.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-dotnet/notify-sharp
	dev-dotnet/ndesk-dbus
	dev-dotnet/ndesk-dbus-glib"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}-${PV}

src_configure() {
	cd "${S}"
	./configure --prefix="${D}"usr
	make
}

src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    emake INSTALL_ROOT="${D}" install || die "Install failed!"
    sed -i '3s|/var/calculate/tmp/portage/net-misc/haguichi-1.0.22/image/|/|g' "${D}/usr/bin/${PN}"
    #kde4-base_src_install
    #qt4-r2_src_install
    #dodir /usr/local/bin
    #cp "${S}"/build/hotshots "${D}"/usr/local/bin
}
