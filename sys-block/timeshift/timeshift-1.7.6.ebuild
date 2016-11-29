# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

VALA_MIN_API_VERSION="0.20"
VALA_MAX_API_VERSION="0.28"
VALA_USE_DEPEND="vapigen"

inherit eutils vala versionator

UURL="https://launchpad.net/~teejee2008/+archive/ubuntu/ppa/+files"
URELEASE="trusty"
UVER_PREFIX="~184~ubuntu14.04.1"

DESCRIPTION="A system restore utility for Linux"
HOMEPAGE="https://launchpad.net/~teejee2008/+archive/ubuntu/ppa/"
SRC_URI="${UURL}/${PN}_${PV}${UVER_PREFIX}.tar.gz"
#SRC_URI="https://launchpad.net/~teejee2008/+archive/ubuntu/ppa/+files/${PN}_${PV}~184~ubuntu14.04.1.tar.gz"

LICENSE="gpl"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror strip"

RDEPEND="$(vala_depend)
	 x11-libs/gtk+
	 net-misc/rsync
	 >=dev-libs/libgee-0.18.0
	 net-libs/libsoup
	 dev-libs/json-glib
	 dev-util/desktop-file-utils"
DEPEND="${RDEPEND}"
S="${WORKDIR}/${PN}-${PV}~184~ubuntu14.04.1"

src_unpack() {
        cd ${S}
	unpack ${A}
}

src_prepare() {
	vala_src_prepare
	export VALA_API_GEN="$VAPIGEN"
	local valaver="$(vala_best_api_version)"
	sed -i "14s|valac|valac-${valaver}|g" src/makefile || die "sed failed"
        sed -i "9s|Caption|X-Caption|g" src/${PN}.desktop || die "sed failed"
        eautoreconf
}

src_install() {
	emake DESTDIR=${D} install || die "emake install failed!"
}