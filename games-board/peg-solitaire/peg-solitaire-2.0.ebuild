# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-board/peg-e/peg-e-1.1.2.ebuild,v 1.4 2013/12/24 12:56:32 ago Exp $

EAPI=5
inherit eutils gnome2-utils qt4-r2 games

DESCRIPTION="A free and fun board game also known as English peg solitaire or Senku"
HOMEPAGE="https://opendesktop.org/content/show.php/Peg+Solitaire?content=140433"
SRC_URI="http://downloads.sourceforge.net/project/peg-solitaire/version%202.0%20%28March%2C%202013%29/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4"
DEPEND="${RDEPEND}"

src_configure() {
	eqmake4
}


