# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-3.1.2.ebuild,v 1.2 2013/09/05 18:46:59 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{3_4,3_5} )
inherit distutils-r1 eutils

DESCRIPTION="Copy the contents of the screen to a PIL or Pillow image memory"
HOMEPAGE="https://github.com/ponty/pyscreenshot"
SRC_URI="https://github.com/ponty/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/setuptools[${PYTHON_USEDEP}]
	dev-python/EasyProcess[${PYTHON_USEDEP}]
	dev-python/pygtk"
DEPEND="${RDEPEND}"



