# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler-qt4/python-poppler-qt4-0.16.3-r1.ebuild,v 1.1 2013/03/17 17:14:40 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3} )

inherit eutils unpacker python-single-r1

DESCRIPTION="Customizable weather widget"
HOMEPAGE="http://sourceforge.net/projects/gis-weather"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${PN}/${PV}/${PN}_${PV}_all.deb"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/pygtk
	dev-python/pycairo
	x11-libs/gksu"

#pkg_preinst() {
#	mkdir -p ${D}usr/share/applications
#	cp /$WORKDIR/${P}/${PN}.desktop ${D}usr/share/applications/
#	#domenu usr/share/applications/${PN}.desktop
#}
#pkg_setup() {
#	python_set_active_version 2
#	python_pkg_setup
#}
S=${WORKDIR}

python_compile() {
	cd "${S}"
	#distutils-r1_python_compile
}

src_install() {
	#sed -i '9s|Network|Application;Network|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
        #sed -i '4s|Saves aoudio track from YouTube|Pulls audio tracks from YouTube videos|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
}
