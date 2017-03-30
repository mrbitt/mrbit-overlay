# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} )

inherit eutils python-r1 scons-utils versionator

MY_PV2=$(get_version_component_range 1-2)

DESCRIPTION="Python binding to exiv2, the C++ library for manipulation of EXIF, IPTC and XMP image metadata."
HOMEPAGE="http://tilloy.net/dev/pyexiv2/"
SRC_URI="http://launchpad.net/${PN}/${MY_PV2}.x/${PV}/+download/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE="doc examples"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="${PYTHON_DEPS}
	>=media-gfx/exiv2-0.20
	>=dev-libs/boost-1.48[python,${PYTHON_USEDEP}]"
DEPEND=">=dev-util/scons-0.97
	doc? ( >=dev-python/sphinx-1.1.3-r2[${PYTHON_USEDEP}] )
	${RDEPEND}"

src_prepare() {
	epatch "${FILESDIR}"/scons_python_abi.patch
}

src_configure() {
	# Scons does not support out-of-source builds - copy sources to build directory
	python_copy_sources

	myesconsargs=(DESTDIR="${D}")

	python_configure() {
		if [[ ${EPYTHON} == python3.* ]]; then
			2to3 --no-diffs --write --nobackups "${BUILD_DIR}" || die "Conversion to python 3 failed"
		fi
	}
	python_foreach_impl python_configure
}

# Helper function to properly run escons for specific python version
# Function accepts SCons targets as optional arguments
escons_for_python_impl() {
	# Go to build directory (which contains copy of sources).
	pushd "${BUILD_DIR}" >/dev/null || die "Could not move to build directory."

	# Each python implementation has different BOOSTLIB variable to be passed to escons,
	# 	so we cannot store it in 'myesconargs' variable
	escons $@ PYTHONINC="$(python_get_includedir)" PYTHONLIB="$(python_get_sitedir)" BOOSTLIB="boost_python-${EPYTHON#python}" 

	popd >/dev/null || die " Could not get out of build directory"
}

src_compile() {

	python_foreach_impl escons_for_python_impl lib

	if use doc; then
		python_setup
		escons doc
	fi
}

src_test() {
	python_foreach_impl escons_for_python_impl test
}

src_install() {
	python_foreach_impl escons_for_python_impl install
	dodoc NEWS README todo

	if use doc; then
		python_setup
		insinto /usr/share/doc/${PF}/
		doins -r doc/html # no dohtml due to mixed content
	fi
	if use examples; then
		insinto /usr/share/doc/${PF}/examples
		doins src/*.py
	fi
}
