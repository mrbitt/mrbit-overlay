# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils cmake-utils

DESCRIPTION="A tesseract OCR front-end"
HOMEPAGE="http://www.sourceforge.com/projects/gimagereader"
#SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="scanner +gtk qt4 qt5"

DEPEND="
	app-text/tesseract
	>=app-text/qtspell-0.8
	qt4? (
	      app-text/poppler[qt4]
         )
	
	qt5? (
	      app-text/poppler[qt5]
         )
    
    gtk? (
           dev-cpp/gtkmm[3]
           app-text/gtkspellmm[3]
           dev-cpp/gtksourceviewmm[3]
           >=dev-cpp/cairomm-1.10
           dev-cpp/pangomm[1.4]
           >=dev-libs/json-glib-1.0
           dev-cpp/libxmlpp[2.6]
          )
	scanner? ( media-gfx/sane-backends )"
	
DEPEND="${RDEPEND}"	

S="${WORKDIR}/${P}"

src_prepare() {
	if use qt4 ; then
	   sed -i '15s|TYPE "qt5"|TYPE "qt4"|g' CMakeLists.txt || die "sed failed"
      
	elif use gtk ; then
	   sed -i '15s|TYPE "qt5"|TYPE "gtk"|g' CMakeLists.txt || die "sed failed"
	   #sed -i "71s|GTKSPELLMM REQUIRED gtkspellmm-3.0>=3.0.4|GTKSPELL REQUIRED gtkspell-3.0|g" CMakeLists.txt || die "sed failed"
	   #sed -i -e '71d' CMakeLists.txt || die "sed failed"
    else
		default
    fi
}	
	
