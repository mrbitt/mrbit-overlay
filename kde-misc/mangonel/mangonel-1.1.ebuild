# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="A simple and pretty application launcher for KDE"
HOMEPAGE="https://projects.kde.org/mangonel"
SRC_URI="http://download.kde.org/stable/${PN}/${P}.tar.xz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 x86"

RDEPEND=">=kde-apps/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${P}
#RESTRICT="strip"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    kde4-base_src_configure
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    kde4-base_src_install
}
