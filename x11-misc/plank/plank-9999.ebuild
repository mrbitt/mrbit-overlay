# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
VALA_MIN_API_VERSION=0.16
VALA_USE_DEPEND=vapigen

inherit bzr vala

DESCRIPTION="Stupidly simple."
HOMEPAGE="https://launchpad.net/plank"
EBZR_REPO_URI="lp:plank"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=">=dev-libs/glib-2.32:2
	dev-libs/libgee:0
	x11-libs/gtk+:3
	x11-libs/bamf:3
	x11-libs/libX11
	x11-libs/libwnck:3"
DEPEND="${RDEPEND}
	$(vala_depend)
	dev-util/intltool
	gnome-base/gnome-common
	sys-devel/gettext
	virtual/pkgconfig"

DOCS=( AUTHORS COPYRIGHT )

src_prepare() {
	NOCONFIGURE=1 REQUIRED_PKG_CONFIG_VERSION=0.1 ./autogen.sh
	vala_src_prepare
}
