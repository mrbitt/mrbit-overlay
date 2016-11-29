# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils gkrellm-plugin

DESCRIPTION="A Gkrellm2 plugin that ping several machines and display the trip time and status"
HOMEPAGE="https://github.com/jmakovicka/gkrellm-multiping"
SRC_URI="https://github.com/jmakovicka/gkrellm-multiping/archive/master.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${PN}-master

RDEPEND="x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXext"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=app-admin/gkrellm-2"

PLUGIN_SO=multiping.so

src_install() {
	gkrellm-plugin_src_install
}

