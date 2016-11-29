# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Simple tool for managing conky scripts"
HOMEPAGE="http://www.teejeetech.in/p/conky-manager.html"
SRC_URI="http://ppa.launchpad.net/teejee2008/ppa/ubuntu/pool/main/c/${PN}/${PN}_${PV}~105~ubuntu14.10.1.tar.xz"
LICENSE="GPL-2"
SLOT="0"

inherit eutils

KEYWORDS="amd64 x86"

RDEPEND="sys-devel/gettext
	 dev-lang/vala"
DEPEND="${RDEPEND}
    x11-libs/cairo
    app-admin/conky
    app-arch/p7zip
    net-libs/libsoup
    dev-libs/libgee
    dev-libs/json-glib
    media-gfx/imagemagick
    x11-libs/gtk+:3
    dev-util/desktop-file-utils
    net-misc/rsync"
    
S="${WORKDIR}/recipe-{debupstream}~{revno}"
#RESTRICT="strip"

	
src_install() {
    cd "${S}/src"
    emake DESTDIR="${D}" install || die "emake install failed"
}
