# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit qmake-utils 

#PATCH_V="${MY_PV##${MY_PV%%_*}}"
#MY_PV="${MY_PV%%_*}-Release${PATCH_V/_/-}"

DESCRIPTION="Lumina desktop environment"
HOMEPAGE="http://lumina-desktop.org/"
SRC_URI="https://github.com/trueos/lumina/archive/v${PV}-p1.tar.gz -> ${P}-p1.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~x86"

COMMON_DEPEND="dev-qt/qtcore:5
	dev-qt/qtconcurrent:5
	dev-qt/qtmultimedia:5[widgets]
	dev-qt/qtsvg:5
	dev-qt/qtnetwork:5
	dev-qt/qtwidgets:5
	dev-qt/qtx11extras:5
	x11-libs/libxcb:0
	x11-libs/xcb-util
	x11-libs/xcb-util-image
	x11-libs/xcb-util-wm
	x11-misc/xcompmgr"

DEPEND="${COMMON_DEPEND}
	dev-qt/linguist-tools:5"

RDEPEND="${COMMON_DEPEND}
	app-admin/sysstat
	kde-frameworks/oxygen-icons
	media-sound/alsa-utils
	sys-power/acpi
	x11-apps/xbacklight
	x11-misc/numlockx
	x11-wm/fluxbox"

S="${WORKDIR}/${P}-p1"

src_configure(){
	eqmake5 PREFIX="${ROOT}usr" L_BINDIR="${ROOT}usr/bin" \
		L_ETCDIR="${ROOT}etc" L_LIBDIR="${ROOT}usr/$(get_libdir)" \
		LIBPREFIX="${ROOT}usr/$(get_libdir)" DESTDIR="${D}" CONFIG+="NO_I18N"
}

src_install(){
	# note: desktop files have known validation errors. see:
	# https://github.com/pcbsd/lumina/pull/183
	default
	mv "${D}"/etc/luminaDesktop.conf.dist "${D}"/etc/luminaDesktop.conf || die
	mv "${D}"/?umina-* "${D}"/usr/bin || die
	#rm "${D}"/start-lumina-desktop || die
}
