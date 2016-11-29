# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=3

inherit distutils

DESCRIPTION="Import your images efficiently and reliably"
HOMEPAGE="http://damonlynch.net/rapid/"
SRC_URI="http://launchpad.net/rapid/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="+video"

PYTHON_DEPEND="2:2.7"

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

pkg_setup() {
       python_set_active_version 2
}

src_compile() {
	distutils_src_compile || die
}

src_install( ) {
	distutils_src_install
}
