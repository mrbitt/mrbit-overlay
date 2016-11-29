# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Is an OpenGL-based 3D model editor that works with triangle-based models"
HOMEPAGE="http://www.misfitcode.com/misfitmodel3d/"
SRC_URI="http://downloads.sourceforge.net/project/misfitmodel3d/misfitmodel3d-devel/${P}/${P}a.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND="kde-frameworks/oxygen-icons"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]
    virtual/opengl"
    
S=${WORKDIR}/${P}a
RESTRICT="strip"

src_configure(){
    cd "${S}"
    #qt4-r2_src_configure
    #kde4-base_src_configure
    #cmake .
    #make src_configure() {
   sed -i '23 a\#include <unistd.h>/' ${S}/src/libmm3d/misc.cc
   sed -i '58s/push_back( val );/this->push_back(val);/' ${S}/src/libmm3d//sorted_list.h
   sed -i '131s/push_back( val );/this->push_back(val);/' ${S}/src/libmm3d//sorted_list.h
   econf --prefix=/usr LIBS="-lm"
   #eqmake4 ${PN}.pro
    #make clean && make QMAKE=qmake-qt4
    #./configure.sh --prefix=/usr && make QMAKE=qmake-qt4
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

	
src_install() {
    cd "${S}"
    #emake DESTDIR="${D}" install || die "Install failed!"
    #kde4-base_src_install
    qt4-r2_src_install
    #make install INSTALL_ROOT="${D}"/usr
    #dodir /usr/{bin,share}
    #dodir /usr/share/{applications,knotter,doc}
    #cp "${S}"/${PN} "${D}"/usr/bin
    #cp "${S}"/${PN}.desktop "${D}"usr/share/applications
    #cp -pPR "${S}"/data/* "${D}"usr/share/knotter/
    #cp -pPR "${S}"/man "${D}"usr/share
    #cp -pPR "${S}"/doc "${D}"usr/share
    #rm -R "${D}"var || die
}
