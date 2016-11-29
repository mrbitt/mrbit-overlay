# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="is a simple chronometer application built for KDE"
HOMEPAGE="http://klatexformula.sourceforge.net/"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${PN}/${P}beta/${P}beta.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    app-text/ghostscript-gpl
    sys-apps/help2man
    app-text/texlive-core
    app-doc/doxygen
    dev-util/automoc
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${P}beta
#RESTRICT="strip"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure(){
    cd "${S}"
    kde4-base_src_configure
}

	
src_install() {
    cd "${S}"
    kde4-base_src_install
}
