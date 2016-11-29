# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
MY_VALA_VERSION=0.28
VALA_MIN_API_VERSION=${MY_VALA_VERSION}
VALA_MAX_API_VERSION=${MY_VALA_VERSION}

inherit gnome2 cmake-utils bzr vala eutils

DESCRIPTION="A webapp browser"
HOMEPAGE="https://code.launchpad.net/~erasmo-marin/webby-browser"
SRC_URI=""
EBZR_REPO_URI="lp:webby-browser"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+introspection"

# Check info.py for dulwich and bzr version dependency info.
# The file should be fairly straightforward to understand.
DEPEND="$(vala_depend)
	 dev-libs/gobject-introspection"
RDEPEND="dev-libs/glib
	 x11-libs/gtk+:3
	 dev-libs/granite
	 >=dev-libs/libgee-0.8
	 >=media-libs/clutter-gtk-1.0
	 net-libs/webkit-gtk:4
	 >=net-libs/libsoup-2.4
	>=dev-vcs/bzr-1.15_rc1"

src_prepare() {
	sed -i "s|webkit2gtk-3.0|webkit2gtk-4.0|g" CMakeLists.txt || die "sed failed"
	sed -i -e '71,76d' CMakeLists.txt || die "sed failed"

	vala_src_prepare
	cmake-utils_src_prepare
}

src_configure() {
	local mycmakeargs=(
		-DCMAKE_INSTALL_CONFIG_NAME=gentoo
	        -DCMAKE_INSTALL_PREFIX=/usr
   		-DVALA_EXECUTABLE=${VALAC}
	)
	cmake-utils_src_configure
}

src_install() {
	
	emake -C "${CMAKE_BUILD_DIR}" DESTDIR="${D}" install
	#cmake-utils_src_install
}
