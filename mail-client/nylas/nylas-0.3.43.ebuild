# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib unpacker

DESCRIPTION="An extensible, open-source mail client built on the modern we."
HOMEPAGE="https://nylas.com/N1/"
SRC_URI="https://edgehill.nylas.com/download?platform=linux-deb&_ga=1.2530416.1794670208.1452792407 -> ${P}.deb"

LICENSE="gpl"
SLOT="0"
KEYWORDS="~amd64 ~i686"
IUSE=""

DEPEND="app-arch/dpkg"
RDEPEND="
	gnome-base/gconf:2
	x11-libs/gtk+:2
	virtual/libudev
	dev-libs/libgcrypt
	x11-libs/libnotify
	x11-libs/libXtst
	dev-libs/nss
	gnome-base/gvfs
	x11-misc/xdg-utils
	gnome-base/libgnome-keyring
	"

S=${WORKDIR}

RESTRICT="strip"

src_install() {
        cd "${S}"
	cp -pPR "${S}"/* "${D}"/ || die "copying files failed!"
}
