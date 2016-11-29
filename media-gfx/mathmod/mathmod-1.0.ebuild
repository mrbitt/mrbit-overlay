# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Is a powerful yet easy to use software solution that allows you to perform complex 3D and 4D surface modellin"
HOMEPAGE="http://opendesktop.org/content/show.php/MathMod?content=164114"
SRC_URI="http://sourceforge.net/projects/${PN}/files/MathMod-1.0/Beta/${P}-beta-qt4.zip"

LICENSE="GPL"
SLOT="0"

inherit eutils qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    dev-libs/qjson
    dev-qt/qtopengl
    >=kde-base/kdelibs-4.13:4[aqua=]"
    
S=${WORKDIR}/${P}-beta-qt4
RESTRICT="strip"

src_configure(){
    cd "${S}"
    eqmake4 ${PN}.pro 
}

	
src_install() {
    cd "${S}"
    dodir /usr/{bin,share}
    dodir /usr/share/${PN}
    cp "${S}"/${PN} "${D}"/usr/bin
    newicon ${S}/icon/catenoid_mini_64x64.png "${PN}".png
    cp "${S}"/${PN}collection.js "${D}"/usr/share/${PN}
    make_desktop_entry ${PN} "MathMod"
}
