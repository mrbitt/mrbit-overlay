# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

VALA_MIN_API_VERSION=0.20
VALA_USE_DEPEND=vapigen
inherit vala gnome2-utils

DESCRIPTION="Vala application can calculate the checksum of files (MD5, SHA1, SHA256 and SHA512) and compare it with the checksums user"
HOMEPAGE="https://github.com/Chiheb-Nexus/Vala-Checksum"
SRC_URI="http://opendesktop.org/CONTENT/content-files/174732-${PN}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+gtk3"

RDEPEND="dev-lang/vala
         gtk3? ( x11-libs/gtk+:3 )
         >=kde-frameworks/oxygen-icons-4.14
"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S=${WORKDIR}/${PN}

src_prepare() {
	vala_src_prepare
}

src_compile() {
	local valaver="$(vala_best_api_version)"
	valac-${valaver} --pkg gtk+-3.0 ChecksumGtk.vala 
}

src_install() {
        dodir /usr/bin
        install -m 0755 ChecksumGtk ${D}/usr/bin/
        dodoc LICENSE README.md
        newicon /usr/share/icons/oxygen/16x16/mimetypes/application-x-executable.png ${PN}.png
        make_desktop_entry ChecksumGtk ${PN} ${PN} System;
}

pkg_postinst() {
	gnome2_icon_cache_update
}