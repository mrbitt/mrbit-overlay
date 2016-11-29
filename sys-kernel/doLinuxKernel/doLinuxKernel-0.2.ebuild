# Copyright 1999-2005 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="The easy kernel updater"
HOMEPAGE="http://www.ularx.de/doLinuxKernel"
SRC_URI="http://www.ularx.de/${PN}/v/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE="lilo"

DEPEND="dev-lang/ruby
	net-misc/wget
	lilo? ( sys-boot/lilo )"

src_install() {
	dobin doLinuxKernel || die "dobin failed"

	insinto /etc
	doins doLinuxKernel.yml

	dodoc ChangeLog README AUTHOR THANKS
}

