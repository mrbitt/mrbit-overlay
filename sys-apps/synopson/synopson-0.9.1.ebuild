# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils qmake-utils

DESCRIPTION="A file manager the way I think it should be: two panes for content and one for navigation"
HOMEPAGE="https://github.com/thomasfuhringer/synopson"
SRC_URI="https://github.com/thomasfuhringer/${PN}/archive/V${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="
	 dev-qt/qtcore:5
	 dev-qt/qtgui:5
	dev-qt/qtwidgets:5
"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_compile() {
	    eqmake5 
	    emake || die
}

src_install() {
    dobin Synopson
}
