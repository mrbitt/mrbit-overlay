# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils
DESCRIPTION="cross-platform Git client"
HOMEPAGE="http://www.gitkraken.com"
SRC_URI="http://release.gitkraken.com/linux/gitkraken-amd64.deb"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="strip"
S="${WORKDIR}"

RDEPEND="dev-libs/libgcrypt
         x11-libs/libnotify
         x11-libs/libXtst
         dev-libs/nss
         x11-misc/xdg-utils
         gnome-base/gvfs
         gnome-base/gconf
         gnome-base/libgnome-keyring"
         		
DEPEND="${RDEPEND}
         dev-lang/python
         virtual/libudev"

LICENSE="EULA"

src_prepare() {
	unpack ./control.tar.gz
	unpack ./data.tar.xz
	default
}

src_install() {
	doins -r usr
	fperms 755 /usr/share/gitkraken/gitkraken
}
