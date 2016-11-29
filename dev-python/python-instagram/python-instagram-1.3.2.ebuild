# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_{4,5}} pypy{,3} )
inherit distutils-r1

DESCRIPTION="Instagram API client"
HOMEPAGE="https://pypi.python.org/pypi/python-instagram"
SRC_URI="https://pypi.python.org/packages/source/p/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 amd64"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"
