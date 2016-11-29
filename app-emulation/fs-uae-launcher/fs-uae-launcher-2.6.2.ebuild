# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="sqlite"

inherit eutils distutils-r1

MY_PV="${PV/_}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="PyQt4 launcher for FS-UAE"
HOMEPAGE="http://fs-uae.net/"
SRC_URI="http://fs-uae.net/fs-uae/stable/${MY_PV}/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="|| ( dev-python/PyQt5
	dev-python/pyside )
	dev-python/pygame
	dev-python/python-lhafile
	>=dev-python/six-1.4.1
	app-arch/p7zip
	x11-misc/xdg-utils
	x11-themes/hicolor-icon-theme"
RDEPEND="${DEPEND}"

#PATCHES=("${FILESDIR}/${PN}-drop-bundled-lhafile-and-six.patch")

S="${WORKDIR}/${MY_P}"

src_compile() {
	distutils-r1_src_compile
	emake mo
}

src_install() {
	#distutils-r1_src_install
	python setup.py install --root="${D}"/usr --install-lib="${D}"/usr/share/fs-uae-launcher --install-scripts="${D}"/usr/share/fs-uae-launcher || die
	
	
	emake DESTDIR="${D}" install mo
}
