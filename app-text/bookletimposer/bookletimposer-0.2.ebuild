# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-3.1.2.ebuild,v 1.2 2013/09/05 18:46:59 mgorny Exp $

EAPI="5"
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )
inherit distutils-r1 versionator multilib eutils 

DESCRIPTION="Is an utility to achieve some basic imposition on PDF documents, especially designed to work on booklets"
HOMEPAGE="http://kjo.herbesfolles.org/bookletimposer/index.html"
SRC_URI="http://kjo.herbesfolles.org/${PN}/archive/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=dev-python/pyPdf-1.13
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+
	app-text/pandoc
	dev-python/python-distutils-extra
	dev-python/setuptools[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

python_compile() {
	cd "${S}"
	#distutils-r1_python_compile
}

python_install() {
	cd "${S}"
	#distutils-r1_src_install
	python2 setup.py install --prefix=/usr --root="${D}"/ --optimize=1
	#distutils-r1_python_install
}