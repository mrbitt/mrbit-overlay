# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

PYTHON_DEPEND="2"

inherit python eutils fdo-mime gnome2-utils

DESCRIPTION="A multitrack non-linear video editor"
HOMEPAGE="http://code.google.com/p/flowblade/"
SRC_URI="https://www.dropbox.com/s/qcw3gcyd6uioill/${P}.tar.gz"
#SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-python/gnome-vfs-python:2
	dev-python/numpy
	dev-python/pygtk:2
	media-libs/mlt[python]
	media-plugins/frei0r-plugins
	media-sound/sox[ladspa]
	virtual/ffmpeg"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	#epatch "${FILESDIR}/${P}-fix-install-dir.patch"
	python_convert_shebangs 2 ${PN}
}

src_install() {

	dobin ${PN}

	insinto /usr/share/${PN}
	doins -r Flowblade/*
	doman installdata/${PN}.1
	dodoc README
	doicon -s 128 installdata/${PN}.png
	domenu installdata/${PN}.desktop

	insinto /usr/share/mime/packages/
	doins installdata/${PN}.xml
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_mime_database_update
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
