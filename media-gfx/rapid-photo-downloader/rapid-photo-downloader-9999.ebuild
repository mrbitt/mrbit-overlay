# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI="5"
PYTHON_COMPAT=( python{3_4,3_5} )

inherit distutils-r1 bzr

EBZR_REPO_URI="https://code.launchpad.net/~dlynch3/rapid/trunk"

DESCRIPTION="Import your images efficiently and reliably"
HOMEPAGE="http://damonlynch.net/rapid/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="+video"

RDEPEND=">=dev-lang/python-2.5
		>=dev-python/libgnome-python-2.18
		>=dev-python/pygtk-2.10
		>=dev-python/pyexiv2-0.2
		dev-python/gconf-python
		dev-python/notify-python
		video? ( dev-python/kaa-metadata )"

DEPEND="${RDEPEND}"


src_compile() {
	distutils-r1_src_compile || die
}

src_install( ) {
	distutils-r1_src_install
}
