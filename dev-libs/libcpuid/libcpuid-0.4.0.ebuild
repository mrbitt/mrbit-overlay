# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

inherit autotools

DESCRIPTION="small C library for x86 CPU detection and feature extraction"
HOMEPAGE="https://github.com/anrieff/libcpuid"
SRC_URI="https://github.com/anrieff/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

src_prepare() {
	eautoreconf
}
