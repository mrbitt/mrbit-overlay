# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Realtek r8712u/RTL8191S wireless chipset firmware"
HOMEPAGE="http://www.realtek.com.tw/"
SRC_URI="ftp://ftp.pku.edu.cn/Linux/kernel.org/linux-firmware/rtlwifi/rtl8712u.bin"

LICENSE="freedist"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

src_unpack() {
	mkdir ${S}
}

src_prepare() {
	cp ${DISTDIR}/rtl8712u.bin ${S}
}

src_install() {
	insinto /lib/firmware/rtlwifi
	doins *.bin
}
