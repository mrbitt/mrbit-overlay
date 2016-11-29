# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="A frontend for Amiga FS-UAE Linux emulator (for Gambas3)"
HOMEPAGE="http://sourceforge.net/projects/gfsuae"
SRC_URI="http://sourceforge.net/projects/gfsuae/files/sources/G-FS-UAE-${PV}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
        >=dev-lang/gambas-3.6.2
        media-libs/sdl-gfx
	app-emulation/e-uae"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/G-FS-UAE"


src_configure() {
    cd  ${S}
    gbc3 -e -a -g -t -p -m
    gba3 || return 1
}

src_install() {
	#sed -i 's/Exec=xt7-player-mpv.gambas/Exec=xt7-player-mpv/' ./xt7-player-mpv.desktop
	install -d ${D}/usr/bin
	install -m755 G-FS-UAE.gambas ${D}/usr/bin/G-FS-UAE
	make_desktop_entry "G-FS-UAE" "G-FS-UAE" "G-FS-UAE" "Game;"
	mkdir ${D}/usr/share/pixmaps
	cp -f ${PN}.png ${D}/usr/share/pixmaps/G-FS-UAE.png
	dodoc README
}
