# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"


# The ebuild depends on CMAKE and also the BZR revision control system
# which is used for pulling the source code from the LaunchPad repository
inherit cmake-utils bzr

# Launchpad repository where "cairo-dock-plugins" lives:
EBZR_REPO_URI="lp:cairo-dock-plug-ins"

# You can specify a certain revision from the repository here.
# Or comment it out to choose the latest ("live") revision.
#EBZR_REVISION="2242"

DESCRIPTION="Official plugins for cairo-dock"
HOMEPAGE="https://launchpad.net/cairo-dock-plug-ins/"
# Next line is not needed because the BZR repository is specified further above
SRC_URI=""

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""

# The next line has been stripped down somewhat from a longer version
# used in the ebuilds of other overlays.  For more info, see:
# https://bugs.launchpad.net/cairo-dock-plug-ins/+bug/922981/comments/8
IUSE="alsa exif gmenu gtk3 kde terminal gnote vala webkit xfce xgamma xklavier twitter indicator3 zeitgeist mail"

# Installation instructions (from BZR source) and dependencies are listed here:
# http://glx-dock.org/ww_page.php?p=From%20BZR&lang=en

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	dev-libs/libxml2
	gnome-base/librsvg:2
	sys-apps/dbus
	x11-libs/cairo
	!gtk3? ( x11-libs/gtk+:2 )
	x11-libs/gtkglext
	~x11-misc/cairo-dock-${PV}
	gtk3? ( x11-libs/gtk+:3 )
	alsa? ( media-libs/alsa-lib )
	exif? ( media-libs/libexif )
	gmenu? ( gnome-base/gnome-menus )
	kde? ( kde-frameworks/kdelibs )
	terminal? ( x11-libs/vte:= )
	vala? ( dev-lang/vala:= )
	webkit? ( >=net-libs/webkit-gtk-1.4.0:3 )
	xfce? ( xfce-base/thunar )
	xgamma? ( x11-libs/libXxf86vm )
	xklavier? ( x11-libs/libxklavier )
	gnote? ( app-misc/gnote )
	twitter? ( dev-python/oauth dev-python/simplejson )
	indicator3? ( dev-libs/libindicator:= )
	zeitgeist? ( dev-libs/libzeitgeist )
	mail? ( net-libs/libetpan )
"

DEPEND="${RDEPEND}
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig
	dev-libs/libdbusmenu[gtk3]
"

src_prepare() {
	bzr_src_prepare
}

src_configure() {

	# Next line added because of the same issues/solution as reported on...
	# ... http://glx-dock.org/bg_topic.php?t=5733

	# Where to put this variable declaration was inspired from...
	# http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/x11-libs/cairo/cairo-0.1.18.ebuild?hideattic=0&view=markup
	# However, adding this to "configure" not "compile" because the error show
	# up during configure stage.


	# Next line added because of the same issues/solutions reported on...
	# ... # https://bugs.launchpad.net/cairo-dock-plug-ins/+bug/922981
	# 
	# With a solution inspired on...
	# http://code.google.com/p/rion-overlay/source/browse/x11-misc/cairo-dock-plugins/cairo-dock-plugins-2.3.9999.ebuild?spec=svn71d4acbbb8c297b818ff886fb5dd434a6f54c377&r=71d4acbbb8c297b818ff886fb5dd434a6f54c377

	# Some more info...  http://www.cmake.org/Wiki/CMake_Useful_Variables


	# Adding the "-DLIB_SUFFIX" flag b/c https://bugs.launchpad.net/cairo-dock-core/+bug/1073734	
    mycmakeargs=(
		# broken with 0.99.x (as of cairo-dock 3.3.2)
		"-Denable-upower-support=OFF"
		"-Denable-sound-effects=OFF"
		"-Denable-alsa-mixer=OFF"
		`use gtk3 && echo "-Dforce-gtk2=OFF" || echo "-Dforce-gtk2=ON"` )
	mycmakeargs="${mycmakeargs} -DROOT_PREFIX=${D} -DCMAKE_INSTALL_PREFIX=/usr -DLIB_SUFFIX="
	cmake-utils_src_configure
}
