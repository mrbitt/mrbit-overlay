# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler-qt4/python-poppler-qt4-0.16.3-r1.ebuild,v 1.1 2013/03/17 17:14:40 floppym Exp $

EAPI=5

inherit eutils unpacker

DESCRIPTION="Easy to use, Free and Open-Source Multimedia converter for Linux in Python."
HOMEPAGE="https://opendesktop.org/content/show.php/Curlew?content=155664"
SRC_URI="http://packages.linuxmint.com/pool/main/m/${PN}/${PN}_${PV}_all.deb"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
        dev-python/configparser
	>=media-video/ffmpeg-1
	media-gfx/imagemagick
	net-misc/mintcommon"

S=${WORKDIR}

src_install() {
        #dodir /usr
	cp -R "${S}"/* "${D}"/ || die "copying files failed!"
	sed -i ${D}/usr/share/applications/mintNanny.desktop -e 's:Application;System;Settings;:System;Settings;:' || die
}

pkg_postinst() {
	elog
	elog "It is recommended to change your make.conf"
	elog "add es. PYTHON_TARGETS="python2_7 python3_4" "
	elog "or USE="python_targets_python3_4" emerge -pv ffmulticonverter"
	elog "or add package.use/custom >=media-video/curlew-0.2 python_targets_python3_4"
}