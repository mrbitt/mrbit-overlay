# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

KDE_LINGUAS="cs da de es fr hr hu it ja nb nn pl pt ro ru sk sr sv tr zh_CN"
KDE_HANDBOOK="optional"

inherit kde5 

DESCRIPTION="Graphical debugger interface"
HOMEPAGE="http://www.kdbg.org/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="
	$(add_frameworks_dep kconfig)
	$(add_frameworks_dep kconfigwidgets)
	$(add_frameworks_dep kcoreaddons)
	$(add_frameworks_dep ki18n)
	$(add_frameworks_dep kiconthemes)
	$(add_frameworks_dep kwidgetsaddons)
	$(add_frameworks_dep kwindowsystem)
	$(add_frameworks_dep kxmlgui)
	$(add_qt_dep qtgui)
	$(add_qt_dep qtwidgets)
"
RDEPEND="${DEPEND}
		 sys-devel/gdb"

DOCS=( BUGS README ReleaseNotes-${PV} TODO )

PATCHES=( "${FILESDIR}/${PN}-buildfix.patch" )

src_prepare() {
	# allow documentation to be handled by eclass
	mv kdbg/doc . || die
	sed -i -e '/add_subdirectory(doc)/d' kdbg/CMakeLists.txt || die
	echo "add_subdirectory ( doc ) " >> CMakeLists.txt || die
	kde5_src_prepare
}

#src_install() {
	#cmake -DCMAKE_INSTALL_PREFIX=/opt/kde4
	#make || die
	##insinto /usr/share/applications
    ##doins ${PN}.desktop || die
	## hack since ChangeLog-* is automagically installed by eclass
	#rm -f "${ED}"usr/share/doc/${PF}/ChangeLog-pre*
#}
