# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

DESCRIPTION="Kernel Modules (guest) source for Virtualbox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="http://mirror.archlinux.ro/archlinux/community/os/x86_64/${P}-1-x86_64.pkg.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="sys-kernel/dkms"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/usr/src/vboxguest-${PV}_OSE

src_compile() {
	:;
}

src_install() {
	dodir usr/src/${P}
	insinto usr/src/${P}
	doins -r ${S}/*
	# delete shipped dkms.conf
	rm -rf ${ED}usr/src/${P}/dkms.conf
	# inject our dkms.conf
	doins ${FILESDIR}/dkms.conf
}

pkg_postinst() {
	dkms add ${PN}/${PV}
}

pkg_prerm() {
	dkms remove ${PN}/${PV} --all
}
