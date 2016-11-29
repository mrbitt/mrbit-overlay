# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A system restore utility for Linux"
HOMEPAGE="https://launchpad.net/~teejee2008/+archive/ubuntu/ppa/"
SRC_URI="https://launchpad.net/~teejee2008/+archive/ubuntu/ppa/+files/${PN}_${PV}~141~ubuntu14.04.1.tar.gz"

LICENSE="gpl"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror strip"

RDEPEND="x11-libs/gtk+
	 net-misc/rsync
	 =dev-libs/libgee-0.6.8
	 net-libs/libsoup
	 dev-libs/json-glib
	 dev-util/desktop-file-utils"
DEPEND="${RDEPEND}
	  dev-lang/vala"
S="${WORKDIR}/${PN}-${PV}~141~ubuntu14.04.1"

src_unpack() {
        cd ${S}
	unpack ${A}
}
	
src_install() {
	emake DESTDIR=${D} install || die "emake install failed!"
}