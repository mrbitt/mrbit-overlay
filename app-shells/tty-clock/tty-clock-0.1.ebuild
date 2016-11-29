# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="analog clock in ncurses"
HOMEPAGE="https://github.com/xorg62/tty-clock"
SRC_URI="https://github.com/xorg62/${PN}/archive/v0.1.tar.gz -> ${P}.tar.gz"

LICENSE="GPL"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/ncurses"
RDEPEND="${DEPEND}
	>=sys-devel/gcc-4.9.0"
	
S=${WORKDIR}/${P}
#RESTRICT="strip"

src_prepare() {
	#sed -e "s:-lncurses:-lncurses -ltinfo:" -i Makefile || Die error "Failed to fix LFLAGS"
	sed -e "s:/usr/local/bin/:/usr/bin/:" -i Makefile || die "Failed to fix the binary path!"
}

src_configure() {
	emake 
}

src_install() {
    cd "${S}"
    #make install DESTDIR="${D}"
    emake DESTDIR="${D}" install || die "Install failed!"
}