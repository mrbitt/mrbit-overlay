# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit gkrellm-plugin

DESCRIPTION="A Gkrellm2 plugin that ping several machines and display the trip time and status"
HOMEPAGE="https://github.com/jmakovicka/gkrellm-multiping"
SRC_URI="https://sourceforge.net/projects/gknut/files/${PN}/${P}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${P}

RDEPEND="x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXext
	media-libs/imlib"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=app-admin/gkrellm-2"

PLUGIN_SO=gknut.so

src_prepare() {
	sed -i "s:gkrellm/gkrellm.h:gkrellm2/gkrellm.h:" gknut.c || die
	
	sed -i "26s:gtk-config --cflags:pkg-config gtk+-2.0 --cflags:" Makefile || die
	sed -i "27s:gtk-config --libs:pkg-config gtk+-2.0 --libs:" Makefile || die
	
	sed -i "28s:imlib-config --cflags-gdk:pkg-config imlib --cflags:" Makefile || die
	sed -i "29s:imlib-config --libs-gdk:pkg-config imlib --libs:" Makefile || die
	
	sed -i "31s:glib-config --libs:pkg-config glib-2.0 --libs:" Makefile || die
	sed -i "30s:glib-config --cflags:pkg-config glib-2.0 --cflags:" Makefile || die
}


src_install() {
	gkrellm-plugin_src_install
}

