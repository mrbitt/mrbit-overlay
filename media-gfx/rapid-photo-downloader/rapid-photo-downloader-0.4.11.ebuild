# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="Import your images efficiently and reliably"
HOMEPAGE="http://damonlynch.net/rapid/"
SRC_URI="http://launchpad.net/rapid/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="+video"

RDEPEND=">=dev-lang/python-2.5
		>=dev-python/pygtk-2.10
		>=dev-python/pyexiv2-0.3.0
		>=media-gfx/fbida-2.08
		>=media-libs/exiftool-8.65
		dev-python/notify-python
		dev-python/gconf-python
		dev-python/dbus-python
		video? ( dev-python/kaa-metadata 
		app-misc/hachoir-metadata )"

DEPEND="${RDEPEND}"


src_compile() {
	distutils-r1_src_compile || die
}

src_install( ) {
	distutils-r1_src_install
}
