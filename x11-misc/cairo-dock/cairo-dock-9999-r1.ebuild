# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

# The ebuild depends on CMAKE and also the BZR revision control system
# which is used for pulling the source code from the LaunchPad repository
inherit cmake-utils bzr


# The aaunchpad repository where "cairo-dock" lives:
EBZR_REPO_URI="lp:cairo-dock-core"

# You can specify a certain revision from the repository here.
# Or comment it out to choose the latest ("live") revision.
#EBZR_REVISION="959"

DESCRIPTION="Cairo-dock is a fast, responsive, Mac OS X-like dock."
HOMEPAGE="https://launchpad.net/cairo-dock-core/"
# Next line is not needed because the BZR repository is specified further above
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="crypt xcomposite desktop_manager gtk3"


# Installation instructions (from BZR source) and dependencies are listed here:
# http://glx-dock.org/ww_page.php?p=From%20BZR&lang=en

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libxml2:2
	gnome-base/librsvg:2
	net-misc/curl
	sys-apps/dbus
	x11-libs/cairo
	x11-libs/pango
	!gtk3? ( x11-libs/gtk+:2 )
	x11-libs/gtkglext
	x11-libs/libXrender
	gtk3? ( x11-libs/gtk+:3 )
	crypt? ( sys-libs/glibc )
	xcomposite? (
		x11-libs/libXcomposite
		x11-libs/libXinerama
		x11-libs/libXtst
	)
"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	sys-devel/gettext
"

src_prepare() {
	bzr_src_prepare
}

src_configure() {

    # Next line added because of the same issues/solutions reported on...
    # ... # https://bugs.launchpad.net/cairo-dock-plug-ins/+bug/922981
    # 
    # With a solution inspired on...
    # http://code.google.com/p/rion-overlay/source/browse/x11-misc/cairo-dock-plugins/cairo-dock-plugins-2.3.9999.ebuild?spec=svn71d4acbbb8c297b818ff886fb5dd434a6f54c377&r=71d4acbbb8c297b818ff886fb5dd434a6f54c377

    # These CMAKE variables are listed in the BZR installation instructions (link above)
    # Some more info...  http://www.cmake.org/Wiki/CMake_Useful_Variables


	# Adding the "-DLIB_SUFFIX" flag b/c https://bugs.launchpad.net/cairo-dock-core/+bug/1073734	

    mycmakeargs=(
		`use gtk3 && echo "-Dforce-gtk2=OFF" || echo "-Dforce-gtk2=ON"`
		`use desktop_manager && echo "-Denable-desktop-manager=ON" || echo "-Denable-desktop-manager=OFF"`
	)
    mycmakeargs="${mycmakeargs} -DROOT_PREFIX=${D} -DCMAKE_INSTALL_PREFIX=/usr -DLIB_SUFFIX=" 
    cmake-utils_src_configure
}

pkg_postinst() {
	elog "Additional plugins are available to extend the functionality"
	elog "of Cairo-Dock. It is recommended to install at least"
	elog "x11-pluings/cairo-dock-plugins."
	elog
	elog "Cairo-Dock is an app that draws on a RGBA GLX visual."
	elog "Some users have noticed that if the dock is launched,"
	elog "severals qt4-based applications could crash, like skype or vlc."
	elog "If you have this problem, add the following line into your bashrc :"
	echo
	elog "alias vlc='export XLIB_SKIP_ARGB_VISUALS=1; vlc; unset XLIB_SKIP_ARGB_VISUALS'"
	elog "see http://www.qtforum.org/article/26669/qt4-mess-up-the-opengl-context.html for more details."
}
