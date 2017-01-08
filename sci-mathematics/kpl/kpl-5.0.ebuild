# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"
_Ver=1483894230

DESCRIPTION="kde/Qt5 based program for two- and three-dimensional graphical presentation of data sets and functions"
HOMEPAGE="https://www.linux-apps.com/p/1127964"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/${_Ver}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

inherit eutils kde5

KEYWORDS="amd64 x86"
IUSE="static-libs +examples +doc"

RDEPEND=""
DEPEND="${RDEPEND}
    dev-qt/qtcore:5
    dev-qt/qtgui:5
    dev-qt/qtmultimedia:5
    dev-qt/qtwidgets:5
    kde-frameworks/threadweaver:5
    kde-frameworks/knotifyconfig:5"
    
S=${WORKDIR}/${PN}

src_prepare() {
	  default
     if ! use doc; then
        sed -i -e "s:#DONOTCOMPILE add_subdirectory(doc):add_subdirectory(doc):"  CMakeLists.txt || die	"sed failed"
     fi
     
     #if ! use examples; then
        #sed -i -e "s:#DONOTCOMPILE add_subdirectory(examples):add_subdirectory(examples):" CMakeLists.txt || die	"sed failed"
     #fi
}

src_install() {
	kde5_src_install
	
	if ! use static-libs ; then
		rm -rf "${D}"/usr/include  || die "include removal failed"
	fi
}	
