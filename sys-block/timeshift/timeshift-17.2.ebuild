# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils vala versionator

DESCRIPTION="A system restore utility for Linux"
HOMEPAGE="https://github.com/teejee2008/timeshift"
SRC_URI="https://github.com/teejee2008/${PN}/archive/v17.2.tar.gz -> ${P}.tar.gz"

LICENSE="gpl"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RESTRICT="mirror strip"

RDEPEND="$(vala_depend)
     x11-libs/gtk+
	 net-misc/rsync
	 x11-libs/vte:2.91[vala] 
	 >=dev-libs/libgee-0.18.0
	 net-libs/libsoup
	 dev-libs/json-glib
	 dev-util/desktop-file-utils "
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
	vala_src_prepare
}

src_compile() {
	local valaver="$(vala_best_api_version)"
	#sed -i "14s|valac|valac-${valaver}|g" src/makefile || die "sed failed"
    sed "s|valac|valac-$(vala_best_api_version)|g" -i src/makefile || die "sed failed"
    sed -i "9s|Caption|X-Caption|g" src/${PN}.desktop || die "sed failed"
	local valaver="$(vala_best_api_version)"
	emake
}


src_install() {
	emake DESTDIR=${D} install || die "emake install failed!"
}
