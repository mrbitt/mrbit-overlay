# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_COMPAT=( python3_4 )

inherit versionator distutils-r1 python-r1 fdo-mime

DESCRIPTION="Create multi boot live Linux on a USB disk...advanced cross-platform application for installing/uninstalling Linux operating system"
HOMEPAGE="http://multibootusb.org/"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${PV}/Source/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"

IUSE="+python +ffmpeg libav"
REQUIRED_USE="|| ( python  )"

RDEPEND="
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-python/pygoocanvas
	dev-python/pygtk
	dev-python/pyxdg[${PYTHON_USEDEP}]
	dev-python/pillow[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	x11-libs/gtk+:2
	sys-block/parted
	app-arch/p7zip
	sys-fs/mtools
	sys-apps/util-linux
"
S=${WORKDIR}/${P}


python_install() {
	distutils-r1_python_install
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
}
