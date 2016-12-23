# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit cmake-utils git-r3

IUSE="
	+filesystemplugin
	urlplugin
	prostopleerplugin
	myzukaruplugin
	notificationsplugin
	yandexmusicplugin
	lastfmplugin
	tunetofileplugin
	mprisplugin
"

DEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtmultimedia:5
	dev-qt/qtnetwork:5
	dev-qt/qtdbus:5
	dev-qt/qtxml:5
	dev-libs/openssl
	media-libs/taglib
	>=media-libs/libcue-1.4.0
"

REQUIRED_USE="filesystemplugin"

RDEPEND="
	${DEPEND}
	dev-qt/qtopengl:5
"

DESCRIPTION="Quick(Qt) Online Music Player - one player for different online music hostings"
HOMEPAGE="http://sourceforge.net/projects/qomp/"
EGIT_REPO_URI="https://github.com/qomp/qomp.git"
EGIT_MIN_CLONE_TYPE="single"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-3"

src_unpack() {
	git-r3_src_unpack
}


src_configure() {
	use filesystemplugin && PLUGINS_FLAGS="${PLUGINS_FLAGS};filesystemplugin"
	use urlplugin && PLUGINS_FLAGS="${PLUGINS_FLAGS};urlplugin"
	use prostopleerplugin && PLUGINS_FLAGS="${PLUGINS_FLAGS};prostopleerplugin"
	use myzukaruplugin && PLUGINS_FLAGS="${PLUGINS_FLAGS};myzukaruplugin"
	use notificationsplugin && PLUGINS_FLAGS="${PLUGINS_FLAGS};notificationsplugin"
	use yandexmusicplugin && PLUGINS_FLAGS="${PLUGINS_FLAGS};yandexmusicplugin"
	use lastfmplugin && PLUGINS_FLAGS="${PLUGINS_FLAGS};lastfmplugin"
	use tunetofileplugin && PLUGINS_FLAGS="${PLUGINS_FLAGS};tunetofileplugin"
	use mprisplugin && PLUGINS_FLAGS="${PLUGINS_FLAGS};mprisplugin"
	local mycmakeargs=(
		$(echo -DBUILD_PLUGINS=${PLUGINS_FLAGS})
	)
	cmake-utils_src_configure
}
