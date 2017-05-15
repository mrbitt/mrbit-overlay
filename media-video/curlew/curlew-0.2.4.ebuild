# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler-qt4/python-poppler-qt4-0.16.3-r1.ebuild,v 1.1 2013/03/17 17:14:40 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{3_2,3_3,3_4,3_5} )

inherit eutils distutils-r1

DESCRIPTION="Easy to use, Free and Open-Source Multimedia converter for Linux in Python."
HOMEPAGE="https://opendesktop.org/content/show.php/Curlew?content=155664"
SRC_URI="http://sourceforge.net/projects/curlew/files/${PN}-${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="ffmpeg libav"

RDEPEND="dev-python/python-poppler-qt4[${PYTHON_USEDEP}]
	dev-python/PyPDF2[${PYTHON_USEDEP}]
	dev-python/dbus-python[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
    dev-python/configparser
	ffmpeg? ( >=media-video/ffmpeg-1 )
	libav? ( media-video/libav )
	media-gfx/imagemagick
	x11-themes/gnome-icon-theme
	media-video/mediainfo"

S=${WORKDIR}/${PN}-${PV}


python_install() {
	cd "${S}"
	python setup.py install --prefix=/usr --root="${D}"/ --optimize=1
}

pkg_postinst() {
	elog
	elog "It is recommended to change your make.conf"
	elog "add es. PYTHON_TARGETS="python2_7 python3_4" "
	elog "or USE="python_targets_python3_4" emerge -pv curlew"
	elog "or add package.use/custom >=media-video/${P} python_targets_python3_4"
}
