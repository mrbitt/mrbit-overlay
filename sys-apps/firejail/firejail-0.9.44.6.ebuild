# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Security sandbox for any type of processes"
HOMEPAGE="https://firejail.wordpress.com/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE="apparmor +bind +chroot +file-transfer +network
	network-restricted +seccomp +userns x11"

src_prepare() {
	#epatch "${FILESDIR}"/${P}-sysmacros.patch
	find -name Makefile.in -exec sed -i -r \
			-e '/CFLAGS/s: (-O2|-ggdb) : :g' \
			-e '1iCC=@CC@' {} + || die
}

src_configure() {
	local myeconfargs=(
		$(use_enable apparmor)
		$(use_enable bind)
		$(use_enable chroot)
		$(use_enable file-transfer)
		$(use_enable network)
		$(use_enable seccomp)
		$(use_enable userns)
		$(use_enable x11)
	)
	use network-restricted && myeconfargs+=( --enable-network=restricted )
	econf "${myeconfargs[@]}"
}
