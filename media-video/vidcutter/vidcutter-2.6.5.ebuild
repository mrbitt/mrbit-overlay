# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{4,5} )

inherit distutils-r1

DESCRIPTION="FFmpeg-based simple video cutter & joiner with a modern PyQt5 GUI"
HOMEPAGE="http://vidcutter.ozmartians.com https://github.com/ozmartian/vidcutter"

if [[ ${PV} == *9999* ]];then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/ozmartian/vidcutter"
	KEYWORDS=""
else
	SRC_URI="https://github.com/ozmartian/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~x86 ~amd64"
fi

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="
	${PYTHON_DEPS}
	dev-python/setuptools[${PYTHON_USEDEP}]
	>=dev-python/PyQt5-5.5[multimedia,${PYTHON_USEDEP}]
"
RDEPEND="${DEPEND}
	virtual/ffmpeg[X,encode]"

S=${WORKDIR}/${P}

DOCS="README.md LICENSE"

src_prepare(){
    sed -i "s/pypi/arch/" vidcutter/__init__.py || die
    sed -i -e '50d' setup.py || die "sed failed"
    sed -i "s/PyQt5 >= 5.5/PyQt5 >= 5.7/" setup.py || die
    eapply_user
}

