# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Isan editor for Celtic knotworks with SVG export capabilities "
HOMEPAGE="http://www.knotdraw.org/"
SRC_URI="https://sourceforge.net/projects/knotter/files/${PV%.*}/${PN}-${PV}.tar.gz"

LICENSE="GPL3"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}-${PV}
RESTRICT="strip"

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    #kde4-base_src_configure
    #cmake .
    #make 
    #eqmake4 ${PN}.pro
    #make clean && make QMAKE=qmake-qt4
    ./configure.sh --prefix=/usr && make QMAKE=qmake-qt4
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    #emake DESTDIR="${D}" install || die "Install failed!"
    #kde4-base_src_install
    qt4-r2_src_install
    #make install INSTALL_ROOT="${D}"/usr
    #dodir /usr/{bin,share}
    #dodir /usr/share/{applications,knotter,doc}
    #cp "${S}"/${PN} "${D}"/usr/bin
    #cp "${S}"/${PN}.desktop "${D}"usr/share/applications
    #cp -pPR "${S}"/data/* "${D}"usr/share/knotter/
    #cp -pPR "${S}"/man "${D}"usr/share
    #cp -pPR "${S}"/doc "${D}"usr/share
    #rm -R "${D}"var || die
}
