# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

KDE_HANDBOOK="forceoptional"
inherit kde5

DESCRIPTION="A backup scheduler for KDE's Plasma desktop"
HOMEPAGE="https://www.linux-apps.com/p/1127689"
SRC_URI="https://github.com/spersson/${PN^}/archive/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
IUSE="libressl +system-libgit2"

CDEPEND="
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep kdbusaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kio)
	$(add_frameworks_dep solid)
	$(add_frameworks_dep kidletime)
	$(add_frameworks_dep knotifications)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kinit)
	$(add_frameworks_dep kjobwidgets)
	$(add_frameworks_dep plasma)
	$(add_qt_dep qtwidgets)
	!libressl? ( dev-libs/openssl:0 )
	libressl? ( dev-libs/libressl:0 )
	system-libgit2? ( dev-libs/libgit2 )
	!system-libgit2? ( net-libs/http-parser )
"
DEPEND="${CDEPEND}
	x11-misc/shared-mime-info
"
RDEPEND="${CDEPEND}
	app-backup/bup
	net-misc/rsync
"

S="${WORKDIR}/${PN^}-${P}" # No joke...

src_configure() {
	local mycmakeargs=(
		-DUSE_SYSTEM_LIBGIT2="$(usex system-libgit2)"
	)

	kde5_src_configure
}
