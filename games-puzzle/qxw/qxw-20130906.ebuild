# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-sports/dustrac/dustrac-1.6.2.ebuild,v 1.1 2013/12/26 13:53:52 hasufell Exp $

EAPI=5

inherit eutils gnome2-utils games

DESCRIPTION="is an open source software which allows us to easily create a crossword"
HOMEPAGE="http://dustrac.sourceforge.net/"
SRC_URI="http://www.quinapalus.com/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/cairo
	dev-libs/libpcre"
DEPEND="${RDEPEND}
	x11-libs/gtk+
	dev-libs/glib"

S="${WORKDIR}/${P}"

pkg_setup() {
	games_pkg_setup
}

src_install() {
	dogamesbin ${PN} || die
	insinto "${GAMES_DATADIR}/${PN}"
	cp -pPR ${S}/examples "${D}"/"${GAMES_DATADIR}/${PN}" || die
	dodoc changelog
	make_desktop_entry ${PN} ${PN} ${GAMES_DATADIR}/bin/${PN} Game
	prepgamesdirs
}

pkg_preinst() {
	games_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	games_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
