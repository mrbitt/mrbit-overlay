# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils wxwidgets

DESCRIPTION="An advanced DICOM viewer and dicomizer"
HOMEPAGE="https://github.com/gerddie/ginkgocadx"
SRC_URI="https://github.com/gerddie/ginkgocadx/archive/${PV}.tar.gz -> ${P}.tar.gz"
RESTRICT="primaryuri"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=sci-libs/vtk-7.0[rendering,imaging,gdal,offscreen,views]
	>=sci-libs/itk-4.8
	dev-db/sqlite
	dev-libs/openssl:0
	|| (
		>=sci-libs/dcmtk-3.6.1_pre20170228
		>=sci-libs/dcmtk-3.6.2-r2[c++11]
	)
	>=x11-libs/wxGTK-3.0.1:3.0[opengl]
	x11-libs/gtk+:2
	!media-gfx/ginkgocadx
	"
RDEPEND="${DEPEND}"

src_prepare() {
        sed -i -e 's#operator const std::string *() const#operator std::string () const#g' cadxcore/api/controllers/imodulecontroller.*
        sed -i "s:vtkgl.h:vtk_glew.h:" cadxcore/widgets/openglhelper.h || die
        sed -i "s:vtkgl.h:vtk_glew.h:" cadxcore/widgets/striptexthelper.cpp || die
        sed -i "s:vtkgl.h:vtk_glew.h:" cadxcore/vtk/widgets/widgetsactor.cpp || die
        sed -i "s:vtkgl.h:vtk_glew.h:" cadxcore/widgets/wanotacionesquina.cpp || die
        sed -i "s:vtkgl.h:vtk_glew.h:" cadxcore/widgets/wangulo.cpp || die
        sed -i "s:vtkgl.h:vtk_glew.h:" cadxcore/widgets/wbrightnesscontrast.cpp || die
}

pkg_setup() {
	if [ "$(wx-config --release)" >= 3.0 ] ; then
		die "Pick wxwidgets-3.0 in 'eselect wxwidgets'"
	fi
}
