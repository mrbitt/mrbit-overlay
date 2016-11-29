# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler-qt4/python-poppler-qt4-0.16.3-r1.ebuild,v 1.1 2013/03/17 17:14:40 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils distutils-r1

DESCRIPTION="Easy to use, Free and Open-Source Multimedia converter for Linux in Python."
HOMEPAGE="https://opendesktop.org/content/show.php/Curlew?content=155664"
SRC_URI="http://sourceforge.net/projects/curlew/files/${PN}-${PV}/${PN}-${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/python-poppler-qt4[${PYTHON_USEDEP}]
	dev-python/pyPdf[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	>=media-video/ffmpeg-1
	media-gfx/imagemagick"

#pkg_preinst() {
#	mkdir -p ${D}usr/share/applications
#	cp /$WORKDIR/${P}/${PN}.desktop ${D}usr/share/applications/
#	#domenu usr/share/applications/${PN}.desktop
#}
#pkg_setup() {
#	python_set_active_version 2
#	python_pkg_setup
#}
S=${WORKDIR}/${PN}-${PV}

python_compile() {
	cd "${S}"
	#distutils-r1_python_compile
}

python_install() {
	cd "${S}"
	#istutils-r1_src_install
	python2 setup.py install --prefix=/usr --root="${D}"/ --optimize=1
	#istutils-r1_python_install
}
