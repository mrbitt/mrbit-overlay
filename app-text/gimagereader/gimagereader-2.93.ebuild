# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python2_7 )
inherit eutils distutils-r1

DESCRIPTION="A tesseract OCR front-end"
HOMEPAGE="http://www.sourceforge.com/projects/gimagereader"
#SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="
	app-text/tesseract
	dev-python/gtkspell-python
	dev-python/pycairo[${PYTHON_USEDEP}]
	dev-python/pyenchant[${PYTHON_USEDEP}]
	dev-python/pygtk:2[${PYTHON_USEDEP}]
	dev-python/python-poppler[${PYTHON_USEDEP}]
	virtual/python-imaging[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P}"

#python_prepare_all() {
#	sed "/data.append/s/'COPYING',//" \
src_configure() {
	econf
}
#		-i setup.py || die
#	distutils-r1_python_prepare_all
#}
