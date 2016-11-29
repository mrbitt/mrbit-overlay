# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils 

DESCRIPTION="Front-End for ClamAV"
HOMEPAGE="http://kde-apps.org/content/show.php/ClamAV-GUI?content=170782"
SRC_URI="http://kde-apps.org/CONTENT/content-files/170782-${P}.tgz"

IUSE=""
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
S=${WORKDIR}/${P}
DEPEND="
	app-antivirus/clamav
	dev-qt/qtcore:4"

RDEPEND="${DEPEND}"

src_configure(){
    cd "${S}"
    qmake clamav-gui.pro
    emake || die
}

src_install() {
    cd "${S}"
    emake INSTALL_ROOT="${D}" install || die
}