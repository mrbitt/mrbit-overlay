# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="Aims to be an 'almost complete' but usable mpv gui (for Gambas3)"
HOMEPAGE="http://pragha.wikispaces.com/ http://github.com/matiasdelellis/pragha"
#SRC_URI="mirror://github/matiasdelellis/${PN}/${P}.tar.bz2"
SRC_URI="https://github.com/kokoko3k/xt7-player-mpv/archive/${PV}.tar.gz -> ${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

COMMON_DEPEND="
        >=dev-lang/gambas-3.6.2
	>=media-video/mpv-0.10.0
	media-libs/taglib
	>=net-misc/youtube-dl-2015.08.28
        media-video/dvbsnoop
	net-misc/wget"
RDEPEND="${COMMON_DEPEND}"

S="${WORKDIR}/${P}"

#src_prepare() {
#	sed -i -e '/CFLAGS/s:-O3 -Werror::' configure || die
#	sed -i -e '/Catego/s:Player:&;:' data/${PN}.desktop.in || die
#	xfconf_src_prepare
#}

src_configure() {
    cd  ${S}
    gbc3 -e -a -g -t -p -m
    gba3 || return 1
}

src_install() {
	sed -i 's/Exec=xt7-player-mpv.gambas/Exec=xt7-player-mpv/' ./xt7-player-mpv.desktop
	install -d ${D}/usr/bin
	install -m755 ${P}.gambas ${D}/usr/bin/xt7-player-mpv
	install -D xt7-player-mpv.png ${D}/usr/share/pixmaps/xt7-player-mpv.png
	install -D xt7-player-mpv.desktop ${D}/usr/share/applications/xt7-player-mpv.desktop
	install -Dm644 ${S}/license.txt ${D}/usr/share/licenses/xt7-player/license.txt
}
