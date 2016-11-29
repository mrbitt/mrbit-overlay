# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler-qt4/python-poppler-qt4-0.16.3-r1.ebuild,v 1.1 2013/03/17 17:14:40 floppym Exp $

EAPI=5

inherit eutils unpacker

DESCRIPTION="Common scripts and resources for Linux Mint. A collection of scripts and resources used by other Linux Mint packages"
HOMEPAGE="https://opendesktop.org/content/show.php/Curlew?content=155664"
SRC_URI="http://packages.linuxmint.com//pool/main/m/mint-common/mint-common_${PV}_all.deb"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_install() {
        #dodir /usr
	cp -R "${S}"/* "${D}"/ || die "copying files failed!"
	#sed -i ${D}/usr/share/applications/mintNanny.desktop -e 's:Application;System;Settings;:System;Settings;:' || die
}

pkg_postinst() {
	elog
	elog "It is recommended to change your make.conf"
	elog "add es. PYTHON_TARGETS="python2_7 python3_4" "
	elog "or USE="python_targets_python3_4" emerge -pv ffmulticonverter"
	elog "or add package.use/custom >=media-video/curlew-0.2 python_targets_python3_4"
}