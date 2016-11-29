# Copyright 1999-2010 Tiziano Müller
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Display graphical dialogs from shell scripts or command line (a Zenity-fork)"
HOMEPAGE="http://code.google.com/p/yad/"
#SRC_URI="http://yad.googlecode.com/files/${P}.tar.xz"
SRC_URI="http://downloads.sourceforge.net/yad-dialog/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk3 icon-browser"

RDEPEND="gtk3? ( x11-libs/gtk+:3 )
	!gtk3? ( x11-libs/gtk+:2 )
	dev-libs/glib:2"
DEPEND="${RDEPEND}
	dev-util/pkgconfig
	sys-devel/gettext
	dev-util/intltool
	app-arch/xz-utils"

src_configure() {
	econf \
		--with-gtk=gtk$(use gtk3 && echo 3 || echo 2) \
		$(use gtk3 || echo "--disable-deprecated") \
		$(use_enable icon-browser)
}
