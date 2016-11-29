# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# 333235
EAPI=4

inherit eutils
DESCRIPTION="Library to create and manage 64-bit disk based hash tables"
HOMEPAGE="http://dbh.sourceforge.net"
SRC_URI="mirror://sourceforge/dbh/${PV}/${P}.tar.gz"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

#S="${WORKDIR}/${P#lib}"

src_install() {
	emake DESTDIR=${D} install || die "emake install failed!"
}


