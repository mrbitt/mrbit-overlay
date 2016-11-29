# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Nonofficial ebuild by Ycarus. For new version look here : http://gentoo.zugaina.org/

inherit eutils

DESCRIPTION="fcrackzip is a zip password cracker"
HOMEPAGE="http://www.goof.com/pcg/marc/fcrackzip.html"
SRC_URI="http://www.goof.com/pcg/marc/data/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
	make DESTDIR="${D}" install || die "Install failed"
	dodoc README INSTALL AUTHORS
	rm "${D}"/usr/bin/zipinfo
}

