# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Qt Graphic Editor"
HOMEPAGE="http://opendesktop.org/content/show.php/Belle?content=155259"
#SRC_URI="http://download.savannah.gnu.org/releases/${PN}/Belle_${PV}a-src.tar.gz"
SRC_URI="https://github.com/fr33mind/Belle/archive/${PV}a.tar.gz -> ${P}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2 fdo-mime

KEYWORDS="amd64 ~mips x86"

RDEPEND="kde-frameworks/oxygen-icons"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    kde-frameworks/kdewebkit
    >=kde-frameworks/kdelibs-4:4"
    
S=${WORKDIR}/Belle-${PV}a

src_prepare() {
	qt4-r2_src_prepare
}

src_configure(){
    eqmake4 editor/${PN}.pro
    make
 }

	
src_install() {
    #qt4-r2_src_install
    mkdir -p "${D}"/usr/{bin,share/{pixmaps,applications}}
    dobin belle
    newicon editor/media/go-to-scene.png Belle.png
    make_desktop_entry "belle" "Belle" "Belle" "Graphics;"
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
}
