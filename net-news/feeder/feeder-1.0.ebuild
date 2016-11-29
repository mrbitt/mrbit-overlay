# Copyright 1999-2011 Sabayon Linux
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils qt4-r2 fdo-mime
DESCRIPTION="Is a Qt application that makes reading atom/rss feeds easy,from system tray and/or indicator area."
HOMEPAGE="http://opendesktop.org/content/show.php/Feeder+-+RSS+Atom+Reader+For+System+Tray?content=167419"

SRC_URI="https://github.com/isamert/${PN}/archive/v1.0.tar.gz -> ${P}.tar.gz "  
#"https://github.com/isamert/${PN}/archive/master.zip -> ${P}.zip"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-qt/qtcore
	dev-qt/qtgui
	"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}/src"

src_compile() {
	eqmake4 ${PN}.pro
	emake || die "make failed"
}

src_install() {
       	qt4-r2_src_install
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
