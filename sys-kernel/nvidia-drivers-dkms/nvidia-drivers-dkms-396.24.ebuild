# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils

NV_URI="http://us.download.nvidia.com/XFree86/"
AMD64_NV_PACKAGE="NVIDIA-Linux-x86_64-${PV}"

DESCRIPTION="NVIDIA driver sources for linux"
HOMEPAGE="http://www.nvidia.com/"
SRC_URI="amd64? ( ${NV_URI}Linux-x86_64/${PV}/${AMD64_NV_PACKAGE}.run )"

LICENSE="GPL-2 NVIDIA-r2"
SLOT="0/${PV}"
KEYWORDS="amd64"
IUSE=""

DEPEND="sys-kernel/dkms"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${AMD64_NV_PACKAGE}"

src_unpack() {
	sh ${DISTDIR}/${AMD64_NV_PACKAGE}.run --extract-only
}

src_prepare() {
	epatch ""${FILESDIR}"/"${P}"-conf.patch"
}

src_install() {
	dodir usr/src/${P}
	insinto usr/src/${P}
	doins -r "${S}"/kernel/*
}

pkg_postinst() {
	dkms add ${PN}/${PV}
}

pkg_prerm() {
	dkms remove ${PN}/${PV} --all
}
