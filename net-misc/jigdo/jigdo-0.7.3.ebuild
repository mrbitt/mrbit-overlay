# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit eutils

DESCRIPTION="Is a tool designed to ease the distribution of very large files over the internet, for example CD or DVD images"

HOMEPAGE="http://atterer.org/jigdo/"
SRC_URI="http://atterer.org/sites/atterer/files/2009-08/${PN}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="doc"


DEPEND="net-misc/curl
        x11-libs/gtk+:3
        app-arch/bzip2"
RDEPEND="${DEPEND}"


src_prepare() {
	eapply_user
	epatch "${FILESDIR}"/${P}-gcc43.patch
}

src_install() {
	default
	newicon gfx/${PN}-icon.png  ${PN}.png||  die "doicons failed!"
	make_desktop_entry ${PN} ${PN} ${PN} "Network;"
	if use doc; then
		dodoc doc/*
	fi
}
