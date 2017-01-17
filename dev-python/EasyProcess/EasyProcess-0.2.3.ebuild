# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1

DESCRIPTION="EasyProcess is an easy to use python subprocess interface."
HOMEPAGE="https://pypi.python.org/pypi/EasyProcess"
SRC_URI="https://github.com/ponty/${PN}/archive/${PV}.tar.gz -> {P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="dev-python/setuptools[${PYTHON_USEDEP}]
sys-fs/fuse"
RDEPEND="!!dev-python/fuse-python"

S=${WORKDIR}/"${P}"

DOCS=( README.rst )

src_install(){
  cd "${S}"
  python setup.py install --root="${D}" --optimize=1 || exit 1
}
