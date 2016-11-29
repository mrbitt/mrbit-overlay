# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-plugins/gkrellm-xkb/gkrellm-xkb-1.05.ebuild,v 1.7 2009/02/19 03:03:56 wormo Exp $

inherit eutils base gkrellm-plugin

DESCRIPTION="A hddtemp plugin for gkrellm2"
HOMEPAGE="http://www.guzu.net/linux/hddtemp.php"
SRC_URI="http://www.guzu.net/files/${P}-beta.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${P}-beta
PLUGIN_SO=gkrellm-hddtemp.so


src_install() {
        cd "${S}"
        sed -i  "s|-Wl||g" "${S}"/Makefile || die "sed failed"
	make gkrellm2
	install -D -m755 gkrellm-hddtemp.so ${D}/usr/lib/gkrellm2/plugins/gkrellm-hddtemp.so || die " install failed"
}