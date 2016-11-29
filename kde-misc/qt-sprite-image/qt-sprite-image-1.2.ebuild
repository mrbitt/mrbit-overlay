# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils cmake-utils

DESCRIPTION="QImageIOPlugin for Half-Life and Quake sprites,for KDE4 environment enabling preview of sprite images in Dolphin and Gwenview"
HOMEPAGE="http://opendesktop.org/content/show.php/Qt+Sprite+Image+Plugin?content=174495"
SRC_URI="https://bitbucket.org/FreeSlave/${PN}-plugin/get/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 +qt5"

DEPEND="qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtsql:4[sqlite]
		dev-qt/qtwebkit:4
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtmultimedia:5
		dev-qt/qtnetwork:5
		dev-qt/qtprintsupport:5
		dev-qt/qtsql:5[sqlite]
		dev-qt/qtwebkit:5
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
	)
	dev-qt/qtsingleapplication[X,qt4(+)?,qt5(-)?]"

RDEPEND="
	${CDEPEND}"

RESTRICT="installsources strip"

S="${WORKDIR}/FreeSlave-${PN}-plugin-e1473fb42ab5/qspr"

src_prepare() {
         cd  ${S}
}

src_configure() {
        if use qt4 ; then
            mv CMakeLists-KDE4.txt CMakeLists.txt
	    mycmakeargs=(
		$(cmake-utils_use_with qt4) )
	else
	    mv CMakeLists-KDE5.txt CMakeLists.txt
	    mycmakeargs=(
	        $(cmake-utils_use_with qt5)
	        export QT_SELECT := qt5 )
	fi 
      cmake-utils_src_configure
}