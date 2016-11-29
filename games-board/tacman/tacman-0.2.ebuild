# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/photofilmstrip/photofilmstrip-1.9.91-r1.ebuild,v 1.1 2013/06/15 15:41:28 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )
#PYTHON_REQ_USE="sqlite"

inherit distutils-r1

DESCRIPTION="Tactical, turn-based clone of the classic PACMAN game."
HOMEPAGE="http://perpetualpyramid.com/drupal/?q=tacman_game"
SRC_URI="http://perpetualpyramid.com/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE="+sdl"

RDEPEND="dev-python/networkx[${PYTHON_USEDEP}]
        virtual/python-imaging[${PYTHON_USEDEP}]
	sdl? ( dev-python/pygame[${PYTHON_USEDEP}] )"

DEPEND="${RDEPEND}"

# Fix bug #472774 (https://bugs.gentoo.org/show_bug.cgi?id=472774)
#PATCHES=(
#	"${FILESDIR}/${P}-PIL_modules_imports_fix.patch"
#)

#DOCS=( CHANGES COPYING README )

src_prepare() {
	distutils-r1_src_prepare
}

src_install() {
	distutils-r1_src_install
}
