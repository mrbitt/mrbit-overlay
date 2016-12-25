# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

VALA_MIN_API_VERSION="0.26"
VALA_MAX_API_VERSION="0.32"
VALA_USE_DEPEND=vapigen

DESCRIPTION="Simple tool for managing conky scripts"
HOMEPAGE="http://www.teejeetech.in/p/conky-manager.html"
#SRC_URI="http://ppa.launchpad.net/teejee2008/ppa/ubuntu/pool/main/c/${PN}/${PN}_${PV}~105~ubuntu14.10.1.tar.xz"
SRC_URI="http://ppa.launchpad.net/teejee2008/ppa/ubuntu/pool/main/c/${PN}/${PN}_${PV}~136~ubuntu16.04.1.tar.xz"
LICENSE="GPL-2"
SLOT="0"

inherit eutils vala versionator

KEYWORDS="amd64 x86"

RDEPEND="sys-devel/gettext
	 $(vala_depend)"
DEPEND="${RDEPEND}
    x11-libs/cairo
    sys-apps/coreutils
    app-admin/conky
    app-arch/p7zip
    net-libs/libsoup
    dev-libs/libgee
    dev-libs/json-glib
    media-gfx/imagemagick
    x11-libs/gtk+:3
    dev-util/desktop-file-utils
    net-misc/rsync"
    
S="${WORKDIR}/${PN}-${PV}~136~ubuntu16.04.1"
#RESTRICT="strip"

src_prepare() {
	vala_src_prepare
	local valaver="$(vala_best_api_version)"
	sed -i "14s|valac|valac-${valaver}|g" src/makefile || die "sed failed"
}

src_install() {
    cd "${S}/src"
       emake DESTDIR="${D}" install || die "emake install failed"
}
