# Copyright 2003 Gentoo Technologies, Xavier Degeneve, and others (see cvs
# changelog.)
# Distributed under the terms of the GNU General Public License v2
# $

inherit eutils

DESCRIPTION="mkcdrec: Make CD-ROM Recovery (a backup system on CD)"
HOMEPAGE="http://mkcdrec.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-boot/syslinux app-shells/ash"
RDEPEND=${DEPEND}

src_unpack() {
	unpack ${A};
	cd ${WORKDIR};
	mv ${PN} ${P};
	if use x86; then
		BOOTARCH=x86;
	elif use amd64; then
		BOOTARCH=x86_64;
	else
		eerror "Cannot select proper arch to use as BOOTARCH.";
		return;
	fi
	sed -i ${P}/Config.sh -e "s/^BOOTARCH=.*$/BOOTARCH=${BOOTARCH}/";
	sed -i ${P}/contributions/mkcdrec -e "s|^MKCDREC_HOME=.*$|MKCDREC_HOME=/usr/share/${P}|";
	mv utilities ${P}/utilities;
	rm -Rf ${P}/doc/.xvpics;
}

src_compile() {
	einfo "Doing nothing.";
}

src_install() {
	insinto /usr/share;
	cp -R ${S} ${D}/usr/share/${P};

	dosbin contributions/mkcdrec;
	doman doc/mkcdrec.8;
	dohtml doc/*;
}
