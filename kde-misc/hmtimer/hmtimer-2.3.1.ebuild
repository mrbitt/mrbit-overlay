# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils qmake-utils

DESCRIPTION="Is a (kde5)graphical shutdown timer for Linux and Windows"
HOMEPAGE="http://opendesktop.org/content/show.php/hmtimer?content=174631"
SRC_URI="http://sourceforge.net/projects/hsiumingstimer/files/${P}/${P}-src.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="+kde5"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtmultimedia:5
	dev-qt/qtdbus:5
	dev-qt/qtnetwork:5"
RDEPEND="${DEPEND}
        media-libs/gst-plugins-base:0.10"
S=${WORKDIR}/${P}

src_compile() {
	cd ${P}
	eqmake5 ${PN}.pro
}

src_install() {
	emake install INSTALL_ROOT="${D}"
	dodoc CHANGELOG LICENSE

}
