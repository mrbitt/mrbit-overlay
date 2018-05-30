# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils

DESCRIPTION="Broadcom's IEEE 802.11a/b/g/n hybrid Linux device driver source"
HOMEPAGE="http://www.broadcom.com/support/802.11/"
SRC_BASE="http://www.broadcom.com/docs/linux_sta/hybrid-v35"
SRC_URI="amd64? ( ${SRC_BASE}_64-nodebug-pcoem-${PV//\./_}.tar.gz )
	http://www.broadcom.com/docs/linux_sta/README_${PV}.txt -> README-${P}.txt"

LICENSE="Broadcom"
KEYWORDS="amd64"
SLOT="0"
RESTRICT="mirror"

DEPEND="sys-kernel/dkms"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_prepare() {
	cp "${FILESDIR}"/dkms.conf "${S}" || die
	
	epatch \
		"${FILESDIR}/broadcom-sta-6.30.223.141-makefile.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.141-eth-to-wlan.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.141-gcc.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.248-r3-Wno-date-time.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.271-r1-linux-3.18.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.271-r2-linux-4.3-v2.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.271-r4-linux-4.7.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.271-r4-linux-4.8.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.271-r4-linux-4.11.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.271-r4-linux-4.12.patch" \
		"${FILESDIR}/broadcom-sta-6.30.223.271-r4-linux-4.15.patch"

	epatch_user
}

src_compile(){
    :
}

src_install() {
    dodir usr/src/${P}
    insinto usr/src/${P}
    doins -r "${S}"/*
}

pkg_postinst() {
    dkms add ${PN}/${PV}
}

pkg_prerm() {
    dkms remove ${PN}/${PV} --all
}
