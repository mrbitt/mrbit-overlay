# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="An interactive visualization 3D program for nbody snapshots"
HOMEPAGE="http://kde-apps.org/content/show.php/glnemo2?content=77881"
SRC_URI="http://projets.lam.fr/attachments/download/1631/${PN}_${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    media-libs/glu"
    
S=${WORKDIR}/${PN}

src_prepare() {
	sed -i '168s/QT5_WRAP_CPP/#QT5_WRAP_CPP/g'  CMakeLists.txt || die "sed failed"
	sed -i '162s/QT5_ADD_RESOURCES/#QT5_ADD_RESOURCES/g'  CMakeLists.txt || die "sed failed"
	sed -i '165s/QT5_WRAP_UI/#QT5_WRAP_UI/g'  CMakeLists.txt || die "sed failed"
	sed -i '132s/QT5_WRAP_CPP/#QT5_WRAP_CPP/g'  CMakeLists.txt || die "sed failed"
	sed -i '193s/qt5_use_modules/#qt5_use_modules/g'  CMakeLists.txt || die "sed failed"
	qt4-r2_src_prepare
}

src_configure(){
    #qmake4 ${PN}.pro
    qmake -recursive
    make
 }

	
src_install() {
    qt4-r2_src_install
    mv "${D}"/tmp/portage/media-gfx/${P}/homedir/bin ${D}/usr
    cp -pPR "${S}"/man "${D}"usr/share
    rm -rd ${D}/tmp || die
}
