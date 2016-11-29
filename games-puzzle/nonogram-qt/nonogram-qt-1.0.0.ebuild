# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-puzzle/colorcode/colorcode-0.7.2.ebuild,v 1.4 2013/03/02 21:18:24 hwoarang Exp $

EAPI=2
inherit eutils qt4-r2 games

MY_PN=nanogram
DESCRIPTION="A nonogram (aka \"paint by numbers\") puzzle game"
HOMEPAGE="http://opendesktop.org/content/show.php/Nonogram-qt?content=155694"
SRC_URI="http://opendesktop.org/CONTENT/content-files/155694-${PN}-${PV}.tar.bz2"
 
LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-qt/qtgui:4 dev-qt/qtgui:4[gtkstyle]"

S=${WORKDIR}/${PN}-${PV}

src_prepare() {
	sed -i -e '/FLAGS/d' ${PN}.pro || die
	qt4-r2_src_prepare
}

src_configure() {
	qt4-r2_src_configure
}

src_install() {
	dogamesbin ${PN} || die
	newicon ${S}/icon.png ${PN}.png
	domenu ${PN}.desktop
	make_desktop_entry ${PN} ${MY_PN}
	dodoc {README,COPYING}
	prepgamesdirs
}
