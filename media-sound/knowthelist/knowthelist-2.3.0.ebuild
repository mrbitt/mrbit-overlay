# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Knowthelist the awesome party music player."
HOMEPAGE="https://github.com/knowthelist/knowthelist"
SRC_URI="https://github.com/knowthelist/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.14:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    media-libs/alsa-lib
    dev-libs/boost
    media-libs/gstreamer
    media-libs/taglib
    >=kde-base/kdelibs-4.14:4[aqua=]"
    
S=${WORKDIR}/${PN}-${PV}
RESTRICT="strip"

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    
    eqmake4 ${PN}.pro
    ./configure.sh --prefix=/usr && make QMAKE=qmake-qt4
   
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    
    qt4-r2_src_install
}
