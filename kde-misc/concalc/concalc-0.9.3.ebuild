# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Concalc is a calculator for the Linux console."
HOMEPAGE="http://extcalc-linux.sourceforge.net/concalcdescr.html"
#SRC_URI="https://github.com/elvisangelaccio/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
SRC_URI="http://downloads.sourceforge.net/extcalc-linux/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    dev-qt/qtopengl
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
