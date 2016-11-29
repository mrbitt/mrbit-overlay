# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils

DESCRIPTION="A simple multiplatform shader editor inspired by Apple's OpenGL Shader Builder"
HOMEPAGE="http://code.google.com/p/qshaderedit/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 qt5"

DEPEND="media-libs/glew
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtopengl:4
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtwidgets:5
		dev-qt/qtopengl:5
	) "
	
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

DOCS=( AUTHORS ChangeLog )

src_configure() {
	if use qt4 || use qt5 ; then
		mycmakeargs+=(
			-DBUILD_QtDialog=ON
			$(cmake-utils_use_find_package qt5 Qt5Widgets)
		)
	fi

	cmake-utils_src_configure
}


src_install() {
       cmake-utils_src_install
       newicon shaders/relief/stone.png ${PN}.png
       mkdir ${D}/usr/share/${PN}
       cp -pPR meshes shaders  "${D}/usr/share/${PN}" || die
       make_desktop_entry "${PN}" "${PN}" "${PN}" "Graphics;"
}