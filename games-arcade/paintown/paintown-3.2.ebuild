# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils games cmake-utils

DESCRIPTION="Side-scrolling beat-em-up in the style of Beats of Rage"
HOMEPAGE="http://paintown.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86"
IUSE=""

RDEPEND=">=media-libs/allegro-4.1
	media-libs/aldumb
	media-libs/freetype
	media-libs/libpng"
DEPEND="${RDEPEND}
	dev-util/cmake"

dir=${GAMES_DATADIR}/${PN}

src_prepare() {
	# Set default datapath
	sed -i \
		-e "/const char \* DATAPATH_ARG/a\\\tUtil\:\:setDataPath(\"${dir}\");" \
		src/main-menu.cpp || die "sed main.cpp"

	sed -i \
		-e "s! -Werror!!" CMakeLists.txt || die "sed -Werror failed"

	epatch "${FILESDIR}/${PV}-gcc44.patch"
}

src_install() {
	dogamesbin ../${P}_build/bin/${PN} || die "dogamesbin failed"

	insinto "${dir}"
	doins -r data/* || die "doins failed"

	make_desktop_entry ${PN} Paintown

	dodoc "${WORKDIR}/${P}"/{README,TODO} || die "dodoc failed"

	prepgamesdirs
}
