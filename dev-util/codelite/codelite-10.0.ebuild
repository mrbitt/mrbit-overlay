# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

WX_GTK_VER="3.0"

inherit cmake-utils wxwidgets xdg

DESCRIPTION="A Free, open source, cross platform C,C++,PHP and Node.js IDE"
HOMEPAGE="http://www.codelite.org"
SRC_URI="https://github.com/eranif/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="clang flex mysql lldb pch sftp webview +wxAuiNotebook wxCrafter"

DEPEND="
	dev-db/sqlite:3
    clang? ( sys-devel/clang:0 )
	flex? ( sys-devel/flex )
	sftp? ( net-libs/libssh )
	lldb? ( || (
		<sys-devel/llvm-3.9[lldb]
		dev-util/lldb
     ) )
	x11-libs/wxGTK:3.0
	mysql? ( virtual/mysql )
"

RDEPEND="${DEPEND}"

CHECKREQS_DISK_BUILD='2G'
inherit check-reqs

L10N_LOCALES=( cs zh_CN )
inherit l10n

src_prepare-locales() {
	local l locales dir="translations" pre="" post="/LC_MESSAGES/codelite.mo"

	l10n_find_changes_in_dir "${dir}" "${pre}" "${post}"

	l10n_get_locales locales app off
	for l in ${locales} ; do
		erm -r "${dir}/${l}"
	done
}

src_prepare() {
	eapply "${FILESDIR}/codelite_dont_strip.patch"
	eapply_user

	src_prepare-locales

	xdg_src_prepare
	cmake-utils_src_prepare

	# respect CXXFLAGS
	sed -e '/CXX_FLAGS/ s|-O2||' -i -- CMakeLists.txt || die
	
}

pkg_setup() {
	setup-wxwidgets
}

src_configure() {
	local mycmakeargs=(
		-DENABLE_CLANG=$(usex clang 1 0)
		-DENABLE_SFTP=$(usex sftp 1 0)
		-DENABLE_LLDB=$(usex lldb 1 0)

		-DWITH_FLEX=$(usex flex 1 0)
		-DWITH_MYSQL=$(usex mysql 1 0)
		-DWITH_PCH=$(usex pch 1 0)
		-DWITH_WEBVIEW=$(usex webview 1 0)
		-DWITH_WXC=$(usex wxCrafter 1 0)
		
		-DGTK_USE_NATIVEBOOK=$(usex !wxAuiNotebook 1 0)
	)

	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install

	erm "${ED}"/usr/share/applications/${PN}.desktop
	local make_desktop_entry_args=(
		"${EPREFIX}/usr/bin/${PN} %f"    # exec
		"CodeLite"	# name
		"${PN}"		# icon
		'Development;IDE;' # categories; https://standards.freedesktop.org/menu-spec/latest/apa.html
	)
	local make_desktop_entry_extras=(
# 		'MimeType=;' # TODO
		"StartupNotify=true"
	)
	make_desktop_entry "${make_desktop_entry_args[@]}" \
		"$( printf '%s\n' "${make_desktop_entry_extras[@]}" )"
}
