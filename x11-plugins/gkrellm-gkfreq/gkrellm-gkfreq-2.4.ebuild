# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils gkrellm-plugin

DESCRIPTION="A Gkrellm2 plugin that displays the current CPU frequencies"
HOMEPAGE="http://sourceforge.net/projects/gkrellm-gkfreq/"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${P}

RDEPEND="sys-power/cpupower
		app-admin/sudo"

PLUGIN_SO=gkrellm-gkfreq.so

src_install() {
	gkrellm-plugin_src_install
}

