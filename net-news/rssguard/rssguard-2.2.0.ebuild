# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils eutils

DESCRIPTION="RSS Guard is a (very) tiny RSS 0.92/1.0/2.0 & ATOM 1.0 feed reader"
HOMEPAGE="http://opendesktop.org/content/show.php/RSS+Guard?content=147872"
SRC_URI="https://bitbucket.org/skunkos/rssguard/downloads/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nls dbus"

RDEPEND="dev-qt/qtcore
	dev-qt/qtgui:4
	dev-qt/qtwebkit:4
	dev-qt/qtxmlpatterns:4
	x11-themes/hicolor-icon-theme
	dbus? ( dev-qt/qtdbus:4 )"
DEPEND="${RDEPEND}"


DOCS=( resources/text/CHANGELOG )

src_prepare() {
	sed -e '/Encoding/d' -i resources/desktop/${PN}.desktop.in || die 'sed failed'
	epatch_user
}

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_enable nls)
	)
	cmake-utils_src_configure
}
