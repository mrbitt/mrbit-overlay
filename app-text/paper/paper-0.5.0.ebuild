# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Fast and light-weight comic book viewer"
HOMEPAGE="http://opendesktop.org/content/show.php/Paper?content=150505"
SRC_URI="http://netcologne.dl.sourceforge.net/project/${PN}-comic/source/0.5/${PN}-${PV}.tar.gz"

LICENSE="LGPL"
SLOT="0"
IUSE="qt4"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=app-text/poppler-0.22[qt4=]
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}-${PV}

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    eqmake4 ${PN}.pro
    #kde4-base_src_configure
    qmake PREFIX=/usr && make
    #make clean && make QMAKE=qmake-qt4 PREFIX=/usr
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    emake INSTALL_ROOT="${D}" install || die "Install failed!"
    #kde4-base_src_install
    #qt4-r2_src_install
    #dodir /usr/local/bin
    #cp "${S}"/build/hotshots "${D}"/usr/local/bin
}
