# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

VALA_MIN_API_VERSION="0.28"
PYTHON_COMPAT=( python2_{6,7} )

inherit vala python-r1 gnome2-utils

DESCRIPTION="Flagship desktop of the Solus Project."
HOMEPAGE="https://github.com/solus-project/budgie-desktop"
SRC_URI="https://github.com/solus-project/budgie-desktop/releases/download/v${PV}/${PN}-${PV}.tar.xz"
LICENSE="GPL-2"
SLOT="10.2"
KEYWORDS="-* ~amd64 ~x86"
IUSE="+introspection systemd"
RESTRICT="mirror"
DEPEND="
	${PYTHON_DEPS}
	$(vala_depend)
	introspection? ( >=dev-libs/gobject-introspection-1.44.0[${PYTHON_USEDEP}] )
	>=x11-libs/gtk+-3.18.6
	systemd? ( 
		sys-apps/systemd
		sys-power/upower[introspection?]
		>=gnome-base/gnome-settings-daemon-3.18.0
	)
	!systemd? ( 
		sys-power/upower-pm-utils[introspection?]
		>=gnome-base/gnome-settings-daemon-3.18.0[openrc-force]
	)
	>=gnome-base/gnome-menus-3.13.3
	>=gnome-base/gnome-session-3.18.1.2
	>=gnome-base/gnome-control-center-3.18.2
	gnome-extra/polkit-gnome
	>=dev-util/desktop-file-utils-0.22
	media-sound/pulseaudio
	>=net-wireless/gnome-bluetooth-3.18.2
	>=gnome-base/gnome-desktop-3.18.2
	>=sys-auth/polkit-0.105
	>=x11-libs/wxGTK-3.0.2.0"
RDEPEND="${DEPEND}
	x11-wm/mutter"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	eapply_user # Add support for user patches
	vala_src_prepare
	intltoolize
	eautoreconf
	export VALAC="$(type -p valac-$(vala_best_api_version))"
}

src_configure() {
	econf --prefix=/usr
}

src_compile() {
	emake || die "Compilation failed!"
}

src_install() {
	emake DESTDIR=${D} install || die "'make install' failed!"
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
