# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

WX_GTK_VER="3.0"
inherit eutils base gnome2-utils wxwidgets

DESCRIPTION="wxGTK cross-platform color picker"
HOMEPAGE="http://opendesktop.org/content/show.php/ColorGrab?content=169053"
SRC_URI="https://github.com/Acolarh/${PN}/archive/v${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	x11-libs/wxGTK:${WX_GTK_VER}[X]"
DEPEND="${RDEPEND}
        >=dev-util/cmake-1.6.7"

S=${WORKDIR}/${P}

src_compile() {
	cmake . \
		-D"CMAKE_INSTALL_PREFIX:STRING=/usr" \
		-D"CMAKE_WXWINDOWS_WXCONFIG_EXECUTABLE:STRING=${wxconfig}" \
		|| die "cmake failed"
	emake || die "make failed"
}

src_install() {
	dodir /usr/bin
	dodir /usr/share/licenses/${PN}
	cp "${S}"/LICENSE "${D}"/usr/share/licenses/${PN}
	cp "${S}"/${PN} "${D}"/usr/bin
	newicon img/16x16.png ${PN}.png
	make_desktop_entry ${PN} ${PN} ${PN} Graphics
}

pkg_preinst() {	gnome2_icon_savelist; }

pkg_postinst() {
	gnome2_icon_cache_update
}