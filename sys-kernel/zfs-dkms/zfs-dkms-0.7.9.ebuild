# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

MY_PN="zfs"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="ZFS sources for linux"
HOMEPAGE="http://zfsonlinux.org/"
SRC_URI="https://github.com/zfsonlinux/zfs/releases/download/zfs-${PV}/${MY_P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64"
IUSE=""
DEPEND="sys-kernel/dkms"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	:
}

src_configure() {
	:
}

src_compile() {
	:
}

src_install() {
	cp "${FILESDIR}/dkms.conf" "${S}" || die
	dodir /usr/src/${P}
	insinto /usr/src/${P}
	doins -r ${S}/*
	fperms 0755 /usr/src/${P}/configure
	fperms 0755 /usr/src/${P}/scripts/dkms.mkconf
	fperms 0755 /usr/src/${P}/scripts/dkms.postbuild
	fperms 0755 /usr/src/${P}/scripts/enum-extract.pl
}

pkg_postinst() {
	dkms add ${PN}/${PV}
}

pkg_prerm() {
	dkms remove ${PN}/${PV} --all
}
