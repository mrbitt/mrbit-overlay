# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Is an application for capturing screens and saving them in a variety of image formats..."
HOMEPAGE="http://opendesktop.org/content/show.php/HotShots?content=158243"
SRC_URI="http://sourceforge.net/projects/hotshots/files/${PV}/${P}-src.zip"

LICENSE="GPL"
SLOT="0"

inherit eutils qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND="x11-libs/libqxt"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4"
    
S=${WORKDIR}/${P}-src

src_configure(){
    sed -i "s/\/usr\/local\/share\/locale/\/usr\/share\/locale/g" ${S}/src/MiscFunctions.cpp || die "sed failed"
    cd "${S}"/build
    sed -i "s/\$1/\/usr/g" hotshots-desktop.sh || die "sed failed"
    sed -i "s/applicationss/applications/g" ${PN}.pro || die "sed failed"
    #kde4-base_src_configure
    #cmake .
    #make 
    qmake -recursive INSTALL_PREFIX=/usr ${PN}.pro
    make
    sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

	
src_install() {
    cd "${S}"/build 
    echo "${WORKDIR}"
    #emake DESTDIR="${D}" install || die "Install failed!"
    #kde4-base_src_install
    qt4-r2_src_install
    dodir /usr/bin
    cp "${S}"/build/release/hotshots "${D}"/usr/bin
}
