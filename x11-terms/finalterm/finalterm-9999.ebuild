# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base vala

DESCRIPTION="A DropDrawers clone. Multiple information organizer"
HOMEPAGE="http://basket.kde.org/"
EGIT_REPO_URI="git://github.com/p-e-w/finalterm.git"
#EGIT_PROJECT="${PN}"

LICENSE="GPL-2"

if [[ ${PV} != *9999* ]]; then
	KDE_LINGUAS="ar bg br bs ca ca@valencia cs cy da de el en_GB eo es et fr ga
	gl hi hne hr hu is it ja ka lt mai ml nb nds nl nn pl pt pt_BR ro ru rw sk
	sv ta tg tr ug uk zh_CN zh_TW"
	SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"
	KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux"
	KDE_HANDBOOK="optional"
else
	KEYWORDS="-libnotify -libunity"
fi

SLOT="4"
IUSE="debug libnotify libunity"

S=${WORKDIR}/${P}

RDEPEND="$(vala_depend)
	dev-libs/keybinder:3
	dev-libs/libgee:0.8
	>=media-libs/clutter-1.12.2
	media-libs/clutter-gtk
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/mx"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig"

src_prepare() {
	vala_src_prepare
}

	
src_configure() {
	local mycmakeargs=(
		-DVALA_EXECUTABLE="${VALAC}"
		-DGSETTINGS_COMPILE=OFF
		-DMINIMAL_FLAGS=ON
	)
	kde4-base_src_configure
	}

	src_install() {
	#cd "${S}"
	kde4-base_src_install
	}