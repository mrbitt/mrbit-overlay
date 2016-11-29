# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/packagekit-gtk/packagekit-gtk-0.8.15.ebuild,v 1.3 2013/12/24 10:54:15 lxnay Exp $

EAPI="3"

inherit eutils base

DESCRIPTION="GTK+3 customizable file manager with advanced unique features"
HOMEPAGE="http://www.packagekit.org/"
SRC_URI="http://jjacky.com/${PN}/${P}.tar.gz"

LICENSE="GPL3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=x11-libs/gtk+-3.0:3"
	
DEPEND="${RDEPEND} virtual/pkgconfig"

S="${WORKDIR}/${P}"

src_configure() {
	econf  --prefix=/usr --sysconfdir=/etc --enable-debug
		
}

src_compile() {
	emake || die "emake install failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
