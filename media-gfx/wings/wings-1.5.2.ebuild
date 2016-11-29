# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"

inherit multilib eutils

DESCRIPTION="excellent 3D polygon mesh modeler"
HOMEPAGE="http://www.wings3d.com/"
SRC_URI="mirror://sourceforge/wings/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha amd64 ppc ppc64 x86"
IUSE=""

RDEPEND="dev-lang/erlang[wxwidgets,-hipe]
	>=media-libs/esdl-1.3.1
	sys-libs/ncurses[tinfo]
	dev-libs/cl"
DEPEND="${RDEPEND}"

pkg_setup() {
	ERL_PATH="/usr/$(get_libdir)/erlang/lib/"
	ESDL_PATH="${ERL_PATH}/$(best_version media-libs/esdl | cut -d/ -f2)"

	WINGS_PATH="${ERL_PATH}/${P}"
}

src_compile() {
	emake
	#ESDL_PATH="${ESDL_PATH}"
}

src_install() {
	find -name 'Makefile*' -delete

	insinto "${WINGS_PATH}"
	doins -r e3d ebin icons plugins plugins_src src fonts

	# Prepare the run script
	sed -e "s:@ESDL_ROOT@:${ESDL_PATH}:" \
		-e "s:@WINGS_ROOT@:${WINGS_PATH}:" \
		"${FILESDIR}"/wings.sh > wings || die
	dobin wings

	dodoc AUTHORS README

	make_desktop_entry wings "Wings3D" wings "Graphics;Application;"
}

