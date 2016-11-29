# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Is a application to temporarity prevents dim screen action of power management and screensaver for KDE environment"
HOMEPAGE="http://kde-apps.org/content/show.php/BoomBox?content=12964"
SRC_URI="http://kde-apps.org/CONTENT/content-files/12964-${P}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit kde4-base

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=media-libs/taglib-1.9.1
    dev-db/sqlite:3
    media-libs/phonon
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${P}

src_configure(){
    cd "${S}"/build
    kde4-base_src_configure
    cmake -DQT_QMAKE_EXECUTABLE=qmake-qt4 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ..
}

src_install() {
    cd "${S}"/build 
   kde4-base_src_install
}
