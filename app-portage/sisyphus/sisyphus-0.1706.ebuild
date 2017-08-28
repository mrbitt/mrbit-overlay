# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

PYTHON_COMPAT=(python2_7)
PYTHON_REQ_USE="threads(+),xml(+)"

inherit eutils 

DESCRIPTION="A GTK+-based frontend to Portage"
HOMEPAGE="http://porthole.sourceforge.net"
SRC_URI="https://github.com/redcorelinux/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm ppc sparc x86 ~x86-fbsd"
IUSE=""

RDEPEND="sys-apps/portage
	dev-python/pygtk:2
	gnome-base/libglade:2.0
	dev-python/pygtksourceview:2
	"
DEPEND="${RDEPEND}"

src_install() {
	emake install DESTDIR="${D}"
}
