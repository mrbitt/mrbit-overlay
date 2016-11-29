# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils bzr 

: ${EBZR_REPO_URI:="lp:${PN}"}


DESCRIPTION="Qt4 cross-platform download manager"
HOMEPAGE="https://launchpad.net/~gloobus-dev/"
#ESVN_REPO_URI="https://code.launchpad.net/~gloobus-dev/covergloobus/trunk"
SRC_URI=""
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND="dev-vcs/bzr
	dev-python/pygtk
	dev-python/pyxdg
	dev-python/dbus-python"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_configure() {
        cd ${S}
	# Don't use econf, not a normal configure script.
	./autogen.sh -prefix="${EPREFIX}/usr" || die
	#./configure --prefix="${EPREFIX}/usr" || die
	make
}

src_install() {
	make "dst_arg=${D}" install
}