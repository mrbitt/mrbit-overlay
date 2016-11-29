# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils git-2

DESCRIPTION="Networking drawing (whiteboarding) program"
HOMEPAGE="http://drawpile.net/"
EGIT_REPO_URI="git://github.com/callaa/Drawpile"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="client server"

REQUIRED_USE="|| ( client server )"

DEPEND="dev-qt/qtcore:5
		dev-qt/qtnetwork:5
		kde-frameworks/karchive:5
		client? ( dev-qt/qtgui:5 )"

RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use client CLIENT)
		$(cmake-utils_use server SERVER)
	)

	cmake-utils_src_configure
}
