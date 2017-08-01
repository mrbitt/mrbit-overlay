# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils qmake-utils fdo-mime

DESCRIPTION="Light html Wysiwyg editor to work self or to integrate on a QT 5+ CMS projekt"
HOMEPAGE="https://github.com/pehohlva/xhtml_edit_qedit_base"

inherit git-r3
EGIT_REPO_URI="${HOMEPAGE}"
SRC_URI=""
KEYWORDS=""

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="
	dev-qt/qtcore:5
"
RDEPEND="${DEPEND}"


src_configure(){
	local myeqmakeargs=(
		xhtml_edit_qedit_base.pro
		PREFIX="${EPREFIX}/usr"
		DESKTOPDIR="${EPREFIX}/usr/share/applications"
		ICONDIR="${EPREFIX}/usr/share/pixmaps"
	)
	eqmake5 ${myeqmakeargs[@]}
}

src_install(){
	default
	dobin XHTML_Editor
	newicon wp.png xhtml_edit.png
	dodoc README.md LICENSE
	make_desktop_entry "XHTML_Editor" "Light html Wysiwyg editor" "xhtml_edit" "Development;IDE;"
}

pkg_postinst(){
	fdo-mime_desktop_database_update
}

pkg_postrm(){
	fdo-mime_desktop_database_update
}
