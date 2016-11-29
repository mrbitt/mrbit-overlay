# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit base git-2

DESCRIPTION="Debian Live - System Build Scripts"
HOMEPAGE="http://live.debian.net/"

SRC_URI="http://http.debian.net/debian/pool/main/l/live-build/${PN}_${PV}.orig.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="debug"

# probably needs more/less crap listed here ...
RDEPEND="
        app-arch/cpio"
DEPEND="${RDEPEND}"

src_unpack() {
	unpack ${A} || die "Could not unpack!"
	#mv ${WORKDIR}/* ${WORKDIR}/${PN} || die "Could not move directory!"
	return
}
