# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-plugins/gimp-lqr/gimp-lqr-0.7.2.ebuild,v 1.2 2013/11/17 23:59:41 phajdan.jr Exp $

EAPI=5

MY_P="${PN}-plugin-${PV}"

inherit eutils

DESCRIPTION="Gimp plugin to load and save files using the new WebP image format."
HOMEPAGE="http://registry.gimp.org/node/25874"
SRC_URI="http://registry.gimp.org/files/${PN}_${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
	>=media-gfx/gimp-2.8
	media-libs/libwebp"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${PN}_${PV}"

src_install() {
	exeinto $(gimptool-2.0 --gimpplugindir)/plug-ins  || die
	doexe file-webp  || die
}