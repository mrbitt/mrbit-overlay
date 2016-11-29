# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="another frontend QT for ffmpeg"
HOMEPAGE="https://code.google.com/p/qwinff/"
SRC_URI="http://download.tuxfamily.org/qet/tags/20130928/${PN}-${PV}-src.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    net-print/cups
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}-${PV}-src
RESTRICT="strip"

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    #kde4-base_src_configure
    #cmake .
    #make 
    eqmake4 ${PN}.pro
    make clean && make QMAKE=qmake-qt4 PREFIX=/usr
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    #emake DESTDIR="${D}" install || die "Install failed!"
    #kde4-base_src_install
    qt4-r2_src_install
    #dodir /usr/local/bin
    #cp "${S}"/build/hotshots "${D}"/usr/local/bin
}
