# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
VALA_MIN_API_VERSION="0.28"
PYTHON_COMPAT=( python2_{6,7} )

inherit gnome2-utils eutils vala python-r1 git-r3

DESCRIPTION="Lightweight GNOME 3-based Desktop Environment used by Solus Project"
HOMEPAGE="http://solus-project.com"
EGIT_REPO_URI="https://github.com/solus-project/budgie-desktop"
SRC_URI=""

LICENSE="LGPL-2.0"
SLOT="0"
KEYWORDS=""
IUSE="+introspection -systemd"

DEPEND="
	${PYTHON_DEPS}
	$(vala_depend)
	introspection? ( >=dev-libs/gobject-introspection-1.44.0[${PYTHON_USEDEP}] )
"
RDEPEND="
	${DEPEND}
	>=app-i18n/ibus-1.5.11
	>=x11-libs/libwnck-3.14.0:3
	>=gnome-base/gnome-menus-3.10.1
	>=dev-libs/libpeas-1.3.0
	dev-util/gtk-doc
	>=x11-wm/mutter-3.18
	dev-util/desktop-file-utils
	dev-libs/libgee[introspection?]
	x11-themes/gnome-themes-standard
	>=x11-libs/gtk+-3.16:3
	media-sound/pulseaudio[X]
	systemd? ( 
		sys-apps/systemd
		sys-power/upower[introspection?]
		>=gnome-base/gnome-settings-daemon-3.18.0
	)
	!systemd? ( 
		sys-power/upower-pm-utils[introspection?]
		>=gnome-base/gnome-settings-daemon-3.18.0[openrc-force]
	)
	dev-util/intltool
	dev-util/meson
	>=gnome-base/gnome-session-3.18.0[systemd?]
	>=x11-terms/gnome-terminal-3.18.0[-gnome-shell]
	gnome-base/gnome-control-center
	gnome-base/nautilus[introspection?]
	>=gnome-base/gnome-desktop-3.18.0:3
	>=sys-auth/polkit-0.105[systemd?]
"

pkg_setup() {
	export MAKE=ninja
	ln -s /usr/bin/valac-$(vala_best_api_version) "${T}/valac"
	export PATH="${PATH}:${T}"
}

src_prepare() {
	vala_src_prepare
	intltoolize
	export VALAC="$(type -p valac-$(vala_best_api_version))"
	sed -i -e '/meson\.add_install_script/d' meson.build
}

src_configure() {
	meson build --prefix=/usr --sysconfdir=/etc --buildtype plain \
		-Dwith-bluetooth=true \
		-Dwith-introspection=$(usex introspection true false) \
		-Dwith-polkit=true \
		-Dwith-stateless=true \
		|| die
}

src_compile() {
	cd "${S}/build"
	emake
}

src_install() {
	cd "${S}/build"
	DESTDIR="${ED}" emake install || die

}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_gconf_install
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_gconf_uninstall
	gnome2_icon_cache_update
}
