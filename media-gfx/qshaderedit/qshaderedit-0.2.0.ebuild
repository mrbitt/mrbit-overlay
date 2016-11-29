# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="I a simple multiplatform shader editor inspired by Apple's OpenGL Shader Builder."
HOMEPAGE="http://opendesktop.org/content/show.php/QShaderEdit+UaDevLab+Edition?content=110443"
SRC_URI="http://opendesktop.org/CONTENT/content-files/110443-${PN}.tar.gz"

LICENSE="GPL3"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-apps/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    dev-util/cmake
    media-libs/glew
    media-gfx/nvidia-cg-toolkit
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}
RESTRICT="strip"

src_configure(){
    cd "${S}"
    cmake -DCMAKE_INSTALL_PREFIX=/usr .
    make 
}

src_install() {
    cd "${S}"
    qt4-r2_src_install
}
