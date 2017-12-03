# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3,3_4} )

inherit distutils-r1 multilib

DESCRIPTION="Program to create video CDs and DVDs, suitable to be played in home DVD players"
HOMEPAGE="http://www.rastersoft.com/programas/devede.html"
SRC_URI="https://github.com/rastersoft/devedeng/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="-mencoder"

RDEPEND="dev-python/dbus-python
	dev-python/pycairo
	dev-python/pygobject:3
	>=dev-python/pygtk-2.16
	media-video/dvdauthor
	mencoder? ( media-video/mplayer[mp3,encode] )
	media-video/vcdimager
	dev-python/urllib3
	dev-python/setuptools
	virtual/cdrtools
	!mencoder? ( virtual/ffmpeg[mp3,encode]
				|| ( media-video/mplayer2[symlink] media-video/mplayer ) )"
DEPEND=""

S=${WORKDIR}/${PN}-${PV}

python_compile() {
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing -lrt"
	distutils-r1_python_compile
}

