# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Krossword playing game and editor for KDE 4"
HOMEPAGE="http://opendesktop.org/content/show.php/Krossword?content=166281"
SRC_URI="http://opendesktop.org/CONTENT/content-files/166281-${P}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit kde4-base

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    kde-apps/libkdegames
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${P}

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"/build
    kde4-base_src_configure
    cmake -DQT_QMAKE_EXECUTABLE=qmake-qt4 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ..
}

src_install() {
    cd "${S}"/build 
    echo "${WORKDIR}"
    kde4-base_src_install
}
