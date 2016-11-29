# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-arch/gzip/gzip-1.6.ebuild,v 1.1 2013/06/11 03:07:21 vapier Exp $

EAPI="4"

inherit eutils flag-o-matic autotools

DESCRIPTION="The FAT16/FAT32 non-destructive resizer"
HOMEPAGE="http://sourceforge.net/projects/fatresize/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
	
DEPEND=">=sys-block/parted-3.1"
RDEPEND="${DEPEND}"

src_prepare() {
        epatch "${FILESDIR}"/${P}-libparted_ver_check.patch
        epatch "${FILESDIR}"/${P}-ped_assert.patch
        epatch "${FILESDIR}"/${P}-ped_free.patch
        eautoreconf
}

src_configure() {
        econf
}

src_install() {
        emake DESTDIR="${D}" install || die
        dodoc AUTHORS ChangeLog README
}