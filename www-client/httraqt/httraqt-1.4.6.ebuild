# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Is the clone from WinHTTrack tool. GUI is based on Qt4 libriaries"
HOMEPAGE="http://qt-apps.org/content/show.php/HTTraQt?content=155711"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

inherit kde4-base

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-apps/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=www-client/httrack-3.48.13
    =dev-qt/qtwebkit-4.8.6-r1
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"/build
    sed -i "9s|httraqt.xpm|httraqt|g" "${S}"/desktop/httraqt.desktop || die "sed failed"
    kde4-base_src_configure
    #cmake -DQT_QMAKE_EXECUTABLE=qmake-qt4 -DCMAKE_INSTALL_PREFIX=/usr ..
}

src_install() {
    cd "${S}"/build 
    echo "${WORKDIR}"
    chmod 0755 "${WORKDIR}"/${P}_build/httraqt || die "chmod failed"
    kde4-base_src_install
    #emake BUILD="${S}"/build  DESTDIR="${D}" install
    #dodoc README CHANGES
}