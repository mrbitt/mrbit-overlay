# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils eutils

DESCRIPTION="CopyQ is advanced clipboard manager with searchable and editable history and more"
HOMEPAGE="http://hluk.github.io/CopyQ"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="auto-paste nls webkit"

RDEPEND="dev-qt/qtcore
	x11-libs/libXfixes
	webkit? ( dev-qt/qtwebkit )
	auto-paste? ( x11-libs/libXtst )"
DEPEND="${RDEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable nls)
	)
	cmake-utils_src_configure
}
