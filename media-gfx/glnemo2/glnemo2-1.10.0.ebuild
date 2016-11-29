# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

NUM=2892

DESCRIPTION="An interactive visualization 3D program for nbody snapshots"
HOMEPAGE="http://kde-apps.org/content/show.php/glnemo2?content=77881"
SRC_URI="http://projets.lam.fr/attachments/download/${NUM}/${PN}-${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils qmake-utils 

KEYWORDS="amd64 ~mips x86"

RDEPEND=""
DEPEND="${RDEPEND}
    dev-qt/qtcore:5
    dev-qt/qtwidgets:5
    dev-qt/qtprintsupport:5
    dev-qt/qtgui:5[egl]
    dev-qt/qtopengl:5
    sci-libs/ccfits
    sys-libs/zlib
    sci-libs/hdf5[cxx]
    media-libs/freeglut
    media-libs/glu"
    
S=${WORKDIR}/${PN}

#src_prepare() {
#	sed -i '168s/QT5_WRAP_CPP/#QT5_WRAP_CPP/g'  CMakeLists.txt || die "sed failed"
#	sed -i '162s/QT5_ADD_RESOURCES/#QT5_ADD_RESOURCES/g'  CMakeLists.txt || die "sed failed"
#	sed -i '165s/QT5_WRAP_UI/#QT5_WRAP_UI/g'  CMakeLists.txt || die "sed failed"
#	sed -i '132s/QT5_WRAP_CPP/#QT5_WRAP_CPP/g'  CMakeLists.txt || die "sed failed"
#	sed -i '193s/qt5_use_modules/#qt5_use_modules/g'  CMakeLists.txt || die "sed failed"
#	qt4-r2_src_prepare
#}

src_configure(){
    #qmake4 ${PN}.pro
    eqmake5 -recursive
    make
 }

	
src_install() {
    #emake INSTALL_ROOT="${D}" install || die
    #emake DESTDIR="${D}" install
    #qt4-r2_src_install
    dodir /usr/{bin,share}
    #dodir /usr/share/{pixmaps,applications,doc}
    cp "${S}"/bin/unix/debug/${PN} ${D}/usr/bin
    cp -pPR "${S}"/man "${D}"usr/share
    newicon "${S}"/res/images/glnemo35.xpm ${PN}.xpm
    make_desktop_entry ${PN} ${PN} ${PN} Utility
    #rm -rd ${D}/tmp || die
}
