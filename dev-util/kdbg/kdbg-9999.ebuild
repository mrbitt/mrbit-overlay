# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6
EGIT_REPO_URI="git://repo.or.cz/${PN}.git"

KDE_LINGUAS="cs da de es fr hr hu it ja nb nn pl pt ro ru sk sr sv tr zh_CN"
KDE_HANDBOOK="optional"
inherit eutils git-r3 kde4-base

SLOT="4"

LICENSE="GPL-2"

DESCRIPTION="[GIT] A Graphical Debugger Interface to gdb."
HOMEPAGE="http://www.kdbg.org/"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE="debug"

RDEPEND=">=sys-devel/gdb-5.0"

DOCS=( BUGS README ReleaseNotes-2.9.0 TODO )

src_prepare() {
	# allow documentation to be handled by eclass
	mv kdbg/doc . || die
	sed -i -e '/add_subdirectory(doc)/d' kdbg/CMakeLists.txt || die
	echo "add_subdirectory ( doc ) " >> CMakeLists.txt || die
	kde4-base_src_prepare
}

src_install() {
	kde4-base_src_install

	# hack since ChangeLog-* is automagically installed by eclass
	rm -f "${ED}"usr/share/doc/${PF}/ChangeLog-pre*
}
