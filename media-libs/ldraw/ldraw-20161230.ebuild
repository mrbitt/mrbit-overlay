# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils toolchain-funcs


DESCRIPTION="LDraw parts library-collection of LDraw-format CAD files representing many of LEGO bricks produced"
HOMEPAGE="http://www.ldraw.org/parts/latest-parts.html"
SRC_URI="http://www.ldraw.org/library/updates/complete.zip -> ${P}.zip"
   
LICENSE="CCPL-Attribution-2.0 LDRAW-NONFREE"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}"


src_install() {
	insinto /usr/share/ldraw
	doins -r *
 # Fix permissions
  find "${D}/usr/share/ldraw" -type f -exec chmod 644 {} +
  find "${D}/usr/share/ldraw" -type d -exec chmod 755 {} +
  
  dodoc Readme.txt CAlicense.txt CAreadme.txt
 
  insinto /etc/profile.d/
  doins "${FILESDIR}"/ldraw-parts-library.sh
  fperms +x /etc/profile.d/ldraw-parts-library.sh || die "perms install failed"
}
