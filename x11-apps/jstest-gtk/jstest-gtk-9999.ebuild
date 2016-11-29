# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit cmake-utils
CMAKE_BUILD_TYPE="Release"

DESCRIPTION="A joystick testing and configuration tool for Linux"
HOMEPAGE="http://http://pingus.seul.org/~grumbel/jstest-gtk/"

LICENSE="GPLv3"
SLOT="0"

if [[ "${PV}" == "9999" ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/Grumbel/jstest-gtk.git"
	KEYWORDS=""
else
	KEYWORDS="~amd64"
	SRC_URI="http://pingus.seul.org/~grumbel/jstest-gtk/${P}.tar.bz2"
fi

RDEPEND="dev-libs/libsigc++
	dev-cpp/gtkmm"
DEPEND="${RDEPEND}
	dev-util/cmake"

src_prepare() {
	epatch ${FILESDIR}/find_data_dir.patch
}
src_configure() {
	cmake-utils_src_configure
}
src_install() {
	dobin "${CMAKE_BUILD_DIR}"/${PN}
	insinto /usr/share/${PN}
	doins -r "${S}"/data

	doicon ${S}/data/generic.png

	make_desktop_entry "${PN}" "${PN}" "generic" "Utility" "Path=/usr/share/${PN}"

}
