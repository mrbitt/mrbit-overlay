# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PLOCALES="af cs de en es fa he it pl pt_BR ru uk zh_TW"
PLOCALE_BACKUP="en it"

inherit cmake-utils l10n

DESCRIPTION="Qt4 GUI configuration tool for Wine"
HOMEPAGE="http://q4wine.brezblock.org.ua/"

# Upstream names the package PV-rX. We change that to
# PV_pX so we can use portage revisions.
MY_PV="${PV/_p/-r}"
MY_P="${PN}-${MY_PV}"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${PN}/${PN}%20${PV}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+dbus debug +icoutils +wineappdb"

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtsingleapplication[qt4(+),X]
	dev-qt/qtsql:4[sqlite]
	dbus? ( dev-qt/qtdbus:4 )
"
RDEPEND="${DEPEND}
	app-admin/sudo
	app-emulation/wine
	>=sys-apps/which-2.19
	sys-fs/fuseiso
	icoutils? ( >=media-gfx/icoutils-0.26.0 )
"

S="${WORKDIR}/${P}"
#S="${WORKDIR}/${P}-r2"

DOCS=( AUTHORS ChangeLog README )

#gen_translation() {
#	lrelease ${P}/src/i18n/${PN}_${1}.ts
#	eend $? || die "failed to generate $1 translation"
#}

src_configure() {
	
	 # l10n_for_each_locale_do gen_translation
	local mycmakeargs=(
		-DLINGUAS="${enabled_linguas}"
		-DQT5=OFF
		-DWITH_SYSTEM_SINGLEAPP=ON
		$(cmake-utils_use debug)
		$(cmake-utils_use_with dbus)
		$(cmake-utils_use_with icoutils)
		$(cmake-utils_use_with wineappdb)
	)
	cmake-utils_src_configure
}
