# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils

DESCRIPTION="macOS -- Based on MacBuntu icon theme"
HOMEPAGE="www.opendesktop.org/p/1102582"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1494895082/macOS.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/macOS"

src_install() {
	insinto /usr/share/icons/macOS
	doins -r * || die
	#dodoc README.md LICENSE
	#rm -f "${D}"/usr/share/icons/macOS/{LICENSE,README.md} || die
	find ${D} -type f -exec chmod 644 {} \;
	find ${D} -type d -exec chmod 755 {} \;
}

pkg_postinst() { gnome2_icon_cache_update; }
