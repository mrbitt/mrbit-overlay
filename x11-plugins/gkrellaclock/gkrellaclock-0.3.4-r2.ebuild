# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gkrellm-plugin toolchain-funcs

IUSE=""
S=${WORKDIR}/${P/a/A}
DESCRIPTION="Nice analog clock for GKrellM2"
SRC_URI="mirror://gentoo/${P}.tar.gz"
HOMEPAGE="http://www.gkrellm.net/"

SLOT="2"
LICENSE="GPL-2"
RDEPEND="app-admin/gkrellm:2[X]"
DEPEND="${RDEPEND}"

KEYWORDS="alpha amd64 ppc sparc x86"

S="${WORKDIR}/${P/a/A}"
PATCHES=( "${FILESDIR}"/${PN}-makefile.patch )
src_prepare() {
	default

	# The tarball contains a pre-compiled x86 object that needs to be
	# removed if we're going to build it properly. See bug 166133.
	rm -f gkrellaclock.o || die 'failed to remove gkrellaclock.o'
}


src_compile() {
	emake CC="$(tc-getCC)"
}
