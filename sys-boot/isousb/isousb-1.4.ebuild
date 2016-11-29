# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/fishsupper/fishsupper-0.1.6.ebuild,v 1.5 2013/02/07 22:04:38 ulm Exp $

EAPI=2
inherit eutils

DESCRIPTION="A graphical tool to copy a hybrid ISO onto a USB key."
HOMEPAGE="http://forum.manjaro.org/index.php?topic=3682"
SRC_URI="http://sourceforge.net/projects/mefiles/files/${PN}-${PV}.tar.gz "

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	gnome-extra/zenity"
DEPEND="${RDEPEND}"


S=${WORKDIR}/${P}


src_install() {
	cd "${S}"
	domenu ${PN}.desktop
	dobin ${PN}
	sed -i ${D}/usr/share/applications/${PN}.desktop -e 's:Categories=System:Categories=System;:' || die
}
