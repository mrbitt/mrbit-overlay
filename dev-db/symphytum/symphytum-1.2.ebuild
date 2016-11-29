# Copyright 1999-2011 Sabayon Linux
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_2,3_3} )

inherit distutils-r1 eutils qt4-r2 fdo-mime

DESCRIPTION="Personal database software"
HOMEPAGE="http://giowck.github.io/symphytum/"

SRC_URI="http://giowck.github.io/${PN}/files/${P}-src.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
DEPEND="dev-python/setuptools
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsql:4
	dev-db/sqlite
"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_configure() {
        cd ${S}
       	eqmake4 Symphytum.pro
}

src_compile() {
	emake || die "make failed"
}

src_install() {
       	dobin ${PN} || die
       	dodoc LICENSE || die
       	insinto /usr/share/
       	doins -r "${S}/stuff/installers/deb/usr/share/applications"
        doins -r "${S}/stuff/installers/deb/usr/share/pixmaps"
        insinto /usr/share/${PN}
        doins -r "${S}/stuff/installers/deb/usr/share/${PN}"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
