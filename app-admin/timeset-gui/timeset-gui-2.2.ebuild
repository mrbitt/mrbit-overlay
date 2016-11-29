# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="A GUI for managing system date and time"
HOMEPAGE="https://github.com/aadityabagga/timeset-gui"
SRC_URI="https://github.com/aadityabagga/${PN}/archive/${PV}.tar.gz  -> ${P}.tar.gz"
    
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/gksu
	     dev-python/pygobject:2
	     net-misc/ntp"

S="${WORKDIR}/${P}"

src_install() {
   make DESTDIR="${D}" install
   rm -Rd "${D}"/usr/share/timeset-gui-2.2 || die
}
