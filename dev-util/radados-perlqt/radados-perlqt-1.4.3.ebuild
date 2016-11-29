# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib unpacker

MY_PV=${PV/_p/-}
MY_PN=${PN%%-bin-debian}

DESCRIPTION="Fast,free secure and powerful web browser based on QtWebkit."
HOMEPAGE="http://radados.org/"
#SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN:0:8}-browser/${PN:0:8}_${MY_PV}_amd64.deb"
#SRC_URI="amd64? ( http://www.slimbeacon.com/slimboat/release/${PN}_amd64.deb )
#	x86? ( http://www.slimbeacon.com/slimboat/release/${PN}_i386.deb )"
SRC_URI="http://perlqt.wikidot.com/local--files/installingperlqt/${PN}.tbz"

LICENSE="gpl"
SLOT="0"
KEYWORDS="~amd64 ~i686"
IUSE=""

DEPEND="app-arch/dpkg"
RDEPEND="
	sys-libs/libstdc++-v3
	dev-util/anjuta
	>=sys-libs/zlib-1.1.4
	dev-qt/designer
	kde-base/perlqt
	"

S=${WORKDIR}/${PN}

QA_PREBUILT="usr/lib*/${MY_PN}/*"

RESTRICT="strip"

src_install() {
        cd "${S}"
	cp -pPR "${S}"/* "${D}"/ || die "copying files failed!"
	rm -Rd "${D}"DEBIAN || die
}
