# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit games

DESCRIPTION="You take on the role of Edgar, battling creatures and solving puzzles"
HOMEPAGE="http://www.parallelrealities.co.uk/p/legend-of-edgar.html"
#SRC_URI="mirror://sourceforge/legendofedgar/${PV}/${PN}-${PV}-1.tar.gz"
SRC_URI="https://github.com/riksweeney//${PN}/releases/download//${PV}//${P}-1.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libsdl
	media-libs/sdl-mixer
	media-libs/sdl-image
	media-libs/sdl-ttf"
DEPEND="${RDEPEND}"

src_prepare(){
	sed -i -e "s:\$(PREFIX)/games/:\$(PREFIX)/games/bin/:g" -i makefile
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
    
    dodir /usr/share/pixmaps
    install -Dm644 icons/48x48.png "${D}"/usr/share/pixmaps/${PN}.png
    
	dodoc doc/* || die "dodoc failed"
}

pkg_postinst() {
	games_pkg_postinst

}
