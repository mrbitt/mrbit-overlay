# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python{2_7,3_4,3_5} )

inherit python-single-r1

DESCRIPTION="A number of classes to assist with creating games, or other real-time applications"
HOMEPAGE="https://pypi.python.org/pypi/gameobjects"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${PN}/${P}.zip"

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
  python2 setup.py install --root="${D}" || exit 1
}
