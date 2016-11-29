# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/www-misc/profile-sync-daemon/profile-sync-daemon-5.45.1.ebuild,v 1.3 2014/03/12 05:21:36 phajdan.jr Exp $

EAPI=3  #noecompress doc

inherit eutils vcs-snapshot

DESCRIPTION="Symlinks and syncs browser profile dirs to RAM"
HOMEPAGE="https://wiki.archlinux.org/index.php/Profile-sync-daemon"
SRC_URI="https://github.com/graysky2/profile-sync-daemon/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="systemd"

RDEPEND="
	app-shells/bash
	net-misc/rsync[xattr]
	systemd? ( sys-apps/systemd )"

src_install() {
	emake DESTDIR="${ED}" \
		$(usex systemd "install-systemd" "")
	if use !systemd; then
		exeinto	/etc/init.d
		doexe ${FILESDIR}/psd
	fi
	emake DESTDIR="${ED}" install-bin
	emake DESTDIR="${ED}" install-man 
}