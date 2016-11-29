# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit distutils-r1 multilib

DESCRIPTION="Graphical tool to make photo collage posters"
SRC_URI="https://github.com/adrienverge/PhotoCollage/archive/v${PV}.tar.gz -> ${P}.tar.gz"
HOMEPAGE="github.com/adrienverge/PhotoCollage"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="dev-python/pygobject:3
	>=dev-python/pygtk-2.16
	dev-python/pillow
	dev-python/setuptools
	"
DEPEND=""

S=${WORKDIR}/PhotoCollage-${PV}

python_compile() {
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing -lrt"
	distutils-r1_python_compile
}
