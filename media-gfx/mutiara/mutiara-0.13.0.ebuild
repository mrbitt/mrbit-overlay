# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/quiterss/quiterss-0.13.3.ebuild,v 1.1 2013/09/04 16:28:11 pinkbyte Exp $

EAPI=5

inherit gnome2 flag-o-matic gnome.org gnome2-utils multilib

DESCRIPTION="Design motifs the fun way"
HOMEPAGE="http://mutiara.sourceforge.net/"
SRC_URI="http://dfn.dl.sourceforge.net/project/mutiara/${PN}-${PV}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="dev-util/intltool
	app-text/gnome-doc-utils
	x11-libs/gtk+:3
	>=x11-libs/cairo-1.14"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${PV}"


src_prepare() {
	    cd "${S}"
	  
}


src_configure() {
          #PKG_CONFIG_PATH=/usr/lib64/pkgconfig/
	  #econf --prefix=/usr LIBS="-lm"
	  ./configure --prefix=/usr LIBS="-lm" PKG_CONFIG_PATH=/usr/lib64/pkgconfig/
	  #gnome2_src_configure
	  make
}

pkg_postinst() {
	gnome2_icon_cache_update
}