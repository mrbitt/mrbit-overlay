# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="Library to create and manage 64-bit disk based hash tables"
HOMEPAGE="http://dbh.sourceforge.net"
SRC_URI="http://sourceforge.net/projects/dbh/files/${PN}/${PV}/${PN}-${PV}.tar.gz"
LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

S=${WORKDIR}/${PN}-${PV}

src_install() {
    cd "${S}"
    emake DESTDIR="${D}" install || die "Install failed!"
}