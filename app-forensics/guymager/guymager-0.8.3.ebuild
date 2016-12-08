# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: blshkv $

EAPI="5"

inherit qt4-r2

DESCRIPTION="Guymager is a fast and user friendly forensic imager."
HOMEPAGE="http://guymager.sourceforge.net/"
#SRC_URI="mirror://sourceforge/guymager/${PV}.tar.gz"
#SRC_URI="mirror://debian/pool/main/g/guymager/${P//-/_}.orig.tar.gz ->  ${P}.tar.gz"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${PN}/LatestSource/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~arm amd64"
IUSE="debug hdparm udisk smart parted qt4 +qt5"

RDEPEND="qt4? (
				dev-qt/qtcore:4
				dev-qt/qtgui:4
				dev-qt/qtdbus:4
	            dev-libs/libguytools2:=[qt4]
	          )
	     qt5? (
	            dev-qt/qtcore:5
				dev-qt/qtgui:5
				dev-qt/qtdbus:5
	            dev-libs/libguytools2:=[qt5]
	          ) "
	
DEPEND="${RDEPEND}
	x11-libs/gksu
	app-forensics/libbfio
	app-forensics/sleuthkit
	app-forensics/libewf
	sys-libs/zlib
	sys-process/procps
	hdparm? ( sys-apps/hdparm )
	udisk? ( sys-fs/udisks )
	smart? ( sys-apps/smartmontools )
	parted? ( sys-block/parted ) "

S="${WORKDIR}/${P}"

PATCHES=(
	# "${FILESDIR}/systemlibs.patch"
	# "${FILESDIR}/support_new_libewf.patch"
)

src_configure() {
		if use qt4 ; then
			eqmake4
	    else
			eqmake5
	    fi
}

src_compile() {
	make
	lrelease guymager.pro

	cd manuals
	./rebuild.sh
}

src_install() {
	dobin guymager
	doman manuals/guymager.1

	insinto /usr/share/guymager
	doins  guymager_*.ts

	insinto /etc/guymager
	doins guymager.cfg

	doicon guymager_128.png
	domenu guymager.desktop
}
