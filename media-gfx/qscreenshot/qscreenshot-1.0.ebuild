# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="A fast and lightweight application used for capturing screenshots...."
HOMEPAGE="http://opendesktop.org/content/show.php/qScreenshot?content=164139"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${P}-src.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils qmake-utils qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND="dev-qt/qtgui"
DEPEND="${RDEPEND}"
    
S=${WORKDIR}/${PN}
RESTRICT="strip"

src_configure(){
   cd "${S}"
    #sed -i "2,1iQMAKE_LRELEASE = /usr/bin/lrelease" "${S}"/"${PN}".pro || die "sed failed"
    sed -i "114s|lrelease-qt4|lrelease|g" "${S}"/src/src.pro || die "sed failed"
    #lrelease ${PN}.pro
    qmake ${PN}.pro
}


src_install() {
    cd "${S}"
    #lrelease ${PN}.pro
    #base_src_install
    #qt4-r2_src_install
    emake INSTALL_ROOT="${D}" install || die "Install failed!"
}    
