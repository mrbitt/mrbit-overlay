# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib unpacker

MY_PV=${PV/_p/-}
MY_PN=${PN%%-bin-debian}

DESCRIPTION="Fast,free secure and powerful web browser based on Google-Chrome."
HOMEPAGE="http://www.slimjet.com/en/dlpage.php"
#SRC_URI="mirror://debian/pool/main/${PN:0:1}/${PN:0:8}-browser/${PN:0:8}_${MY_PV}_amd64.deb"
SRC_URI="amd64? ( http://www.slimjet.com/release/${PN}_amd64.deb )
	x86? ( http://www.slimjet.com/release/${PN}_i386.deb )"
	
LICENSE="Freeware"
SLOT="0"
KEYWORDS="~amd64 ~i686"
IUSE=""

DEPEND="app-arch/dpkg"
RDEPEND="
	sys-libs/libstdc++-v3
	>=dev-libs/openssl-0.9
	>=sys-libs/zlib-1.1.4
	media-libs/libjpeg-turbo
	>=media-libs/gstreamer-0.10
	media-libs/libpng
	"

S=${WORKDIR}

QA_PREBUILT="usr/lib*/${MY_PN}/*"

RESTRICT="strip"

src_install() {
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
	insinto opt/slimjet/lib
	dosym  opt/slimjet/libffmpeg.so opt/slimjet/lib
	#doins opt/slimjet/libffmpeg.so
	
}
