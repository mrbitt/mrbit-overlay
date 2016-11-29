# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-video/photofilmstrip/photofilmstrip-1.9.91-r1.ebuild,v 1.1 2013/06/15 15:41:28 floppym Exp $

EAPI="5"
PYTHON_COMPAT=( python2_{6,7} )

inherit python-single-r1

DESCRIPTION="Stop-motion software"
HOMEPAGE="https://launchpad.net/luciole"
SRC_URI="http://launchpad.net/luciole/0.9/${PV}/+download/${P}.tar.gz"
LICENSE="GPL"
SLOT="0"

KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="ddev-python/gnome-python-base
        dev-python/libgnomecanvas-python
        media-plugins/gst-plugins-gnomevfs
        dev-python/pygtk
        media-gfx/imagemagick
        media-video/mjpegtools
	virtual/python-imaging[${PYTHON_USEDEP}]
	"

DEPEND="${RDEPEND}"

# Fix bug #472774 (https://bugs.gentoo.org/show_bug.cgi?id=472774)
#PATCHES=(
#	"${FILESDIR}/${P}-PIL_modules_imports_fix.patch"
#)

#DOCS=( CHANGES COPYING README )
S="${WORKDIR}/${P}"

src_prepare() {
	python_fix_shebang .
}

src_install() {
	python2 setup.py install --prefix=/usr --root=${D}
}