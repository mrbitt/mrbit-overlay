# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils eutils fdo-mime fortran-2 python-single-r1

DESCRIPTION="QT based Computer Aided Design application"
HOMEPAGE="http://www.freecadweb.org/"

if [[ ${PV} == *9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/FreeCAD/FreeCAD.git"
else
	SRC_URI="https://github.com/FreeCAD/FreeCAD/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~x86"
fi

LICENSE="GPL-2"
SLOT="0"

IUSE="video_cards_nvidia"

#TODO
#add sci-libs/orocos_kdl waiting for Bug https://bugs.gentoo.org/show_bug.cgi?id=604272 (keyword ~x86)
#remove qtwebkit : waiting for Bug http://www.freecadweb.org/tracker/view.php?id=2868

#dev-qt/qtgui:4[-egl] and dev-qt/qtopengl:4[-egl] : Bug 564978
#dev-python/pyside[svg] : Bug 591012
#collada : Bug 606904

COMMON_DEPEND="
	${PYTHON_DEPS}
	dev-cpp/eigen:3
	dev-java/xerces
	dev-libs/boost:=[python,${PYTHON_USEDEP}]
	dev-libs/xerces-c[icu]
	dev-python/matplotlib[${PYTHON_USEDEP}]
	dev-python/pyside[X,svg,${PYTHON_USEDEP}]
	dev-python/shiboken[${PYTHON_USEDEP}]
	dev-qt/designer:4
	dev-qt/qtgui:4[-egl]
	dev-qt/qtopengl:4[-egl]
	dev-qt/qtsvg:4
	dev-qt/qtwebkit:4
	media-libs/coin
	media-libs/freetype
	|| ( sci-libs/opencascade:6.9.1[vtk] sci-libs/opencascade:6.9.0[vtk] sci-libs/opencascade:6.8.0 sci-libs/opencascade:6.7.1 )
	sys-libs/zlib
	virtual/glu
	dev-python/pycollada"

RDEPEND="${COMMON_DEPEND}
	dev-python/numpy[${PYTHON_USEDEP}]
	dev-python/pivy[${PYTHON_USEDEP}]
	dev-qt/assistant:4"
DEPEND="${COMMON_DEPEND}
	>=dev-lang/swig-2.0.4-r1:0
	dev-python/pyside-tools[${PYTHON_USEDEP}]"

REQUIRED_USE="${PYTHON_REQUIRED_USE}"

PATCHES=(
	"${FILESDIR}"/${PN}-0.14.3702-install-paths.patch
)

# https://bugs.gentoo.org/show_bug.cgi?id=352435
# https://www.gentoo.org/foundation/en/minutes/2011/20110220_trustees.meeting_log.txt
RESTRICT="mirror"

# TODO:
#   DEPEND and RDEPEND:
#		salome-smesh - science overlay
#		zipio++ - not in portage yet

S="${WORKDIR}/FreeCAD-${PV}"

DOCS=( README.md ChangeLog.txt )

pkg_setup() {
	fortran-2_pkg_setup
	python-single-r1_pkg_setup

	[[ -z ${CASROOT} ]] && die "empty \$CASROOT, run eselect opencascade set or define otherwise"
}

src_configure() {
	#Bug 606892 : libGL error
	use video_cards_nvidia && append-ldflags -L/usr/$(get_libdir)/opengl/nvidia/lib

	export QT_SELECT=4

	#-DOCC_* defined with cMake/FindOpenCasCade.cmake
	#-DCOIN3D_* defined with cMake/FindCoin3D.cmake
	#-DSOQT_ not used
	#-DFREECAD_USE_EXTERNAL_KDL="ON" waiting for Bug 604130 (keyword ~x86)
	local mycmakeargs=(
		-DOCC_INCLUDE_DIR="${CASROOT}"/inc
		-DOCC_LIBRARY_DIR="${CASROOT}"/$(get_libdir)
		-DCMAKE_INSTALL_DATADIR=share/${P}
		-DCMAKE_INSTALL_DOCDIR=share/doc/${PF}
		-DCMAKE_INSTALL_INCLUDEDIR=include/${P}
		-DFREECAD_USE_EXTERNAL_KDL="OFF"
	)

	# TODO to remove embedded dependencies:
	#
	#	-DFREECAD_USE_EXTERNAL_ZIPIOS="ON" -- this option needs zipios++ but it's not yet in portage so the embedded zipios++
	#                (under src/zipios++) will be used
	#	salomesmesh is in 3rdparty but upstream's find_package function is not complete yet to compile against external version
	#                (external salomesmesh is available in "science" overlay)

	cmake-utils_src_configure
	einfo "${P} will be built against opencascade version ${CASROOT}"
}

src_install() {
	cmake-utils_src_install

	make_desktop_entry FreeCAD "FreeCAD" "" "" "MimeType=application/x-extension-fcstd;"

	# install mimetype for FreeCAD files
	insinto /usr/share/mime/packages
	newins "${FILESDIR}"/${PN}.sharedmimeinfo "${PN}.xml"

	# install icons to correct place rather than /usr/share/freecad
	pushd "${ED%/}"/usr/share/${P} || die
	local size
	for size in 16 32 48 64; do
		newicon -s ${size} freecad-icon-${size}.png freecad.png
	done
	doicon -s scalable freecad.svg
	newicon -s 64 -c mimetypes freecad-doc.png application-x-extension-fcstd.png
	popd || die

	python_optimize "${ED%/}"/usr/{,share/${P}/}Mod/
}

pkg_postinst() {
	fdo-mime_mime_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
}
