# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit eutils toolchain-funcs flag-o-matic

DESCRIPTION="Advanced file encryption using AES"
HOMEPAGE="http://www.aescrypt.com/"
SRC_URI="https://www.aescrypt.com/download/v3/linux/${P}.tgz"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static"

DEPEND=""
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}/src

src_prepare() {
	epatch "${FILESDIR}/${P}-build.patch"
	epatch "${FILESDIR}/${P}-iconv.patch"
}

src_compile() {
	if use static; then
		append-cflags "-DDISABLE_ICONV"
		append-ldflags "-static"
	fi
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}" CC="$(tc-getCC)"
}

src_install() {
        #cd ${WORKDIR}/${P}/gui
        emake DESTDIR="${D}" install
        mkdir -p "${D}"/usr/share/{aescrypt,applications}
        cp ${WORKDIR}/${P}/gui/aescrypt-gui "${D}"/usr/bin && chmod +x "${D}"/usr/bin/aescrypt-gui
        cp ${WORKDIR}/${P}/gui/SmallLock.png "${D}"/usr/share/${PN}
      sed -i "10s|Application;||g" ${WORKDIR}/${P}/gui/AESCrypt.desktop || die "sed failed"
      sed -i "11s|all/allfiles;||g" ${WORKDIR}/${P}/gui/AESCrypt.desktop || die "sed failed"
      sed -i "12s|true||g" ${WORKDIR}/${P}/gui/AESCrypt.desktop || die "sed failed"
        cp ${WORKDIR}/${P}/gui/AESCrypt.desktop "${D}"/usr/share/applications
}
