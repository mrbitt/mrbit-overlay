# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )
inherit python-r1 multilib

MY_PN="Swine"
MY_P="${MY_PN}-${PV}"

if [[ ${PV} == "9999" ]]; then
	EGIT_REPO_URI="git://github.com/dswd/${MY_PN}.git"
	EGIT_BRANCH="master"
	inherit git-r3
	SRC_URI=""
	#KEYWORDS=""
else
	SRC_URI="https://github.com/dswd/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64" #~x86
	S="${WORKDIR}/${MY_P}"
fi

DESCRIPTION="A Qt interface for managing Wine prefixes and installations"
HOMEPAGE="http://http://www.swine-tool.de/"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

DEPEND="${PYTHON_DEPS}
	dev-python/PyQt4[${PYTHON_USEDEP}]
	dev-qt/qtcore:4"
RDEPEND="${DEPEND}
	app-arch/cabextract
	app-emulation/wine
	app-emulation/winetricks
	media-gfx/icoutils"

# These use a non-standard wine category which is provided by app-emulation/wine
QA_DESKTOP_FILE="usr/share/applications/swine.desktop
usr/share/applications/swine-extensions.desktop"

src_unpack(){
	if [[ ${PV} == "9999" ]]; then
		git-r3_src_unpack
	else
		unpack "${P}".tar.gz
	fi
}

src_prepare(){
	# need a different path to the exe
	sed -i 's/lrelease-qt4/\/usr\/lib\/qt4\/bin\/lrelease/g' Makefile || \
		die "Failed to patch Makefile"
	# remove absolute path for icon in .desktop
	sed -i 's:/usr/share/swine/images/swine32.png:swine:' \
		resources/swine.desktop || die "Failed to patch desktop file"
}

src_compile(){
	emake
}

src_install(){
	my_install(){
#		local python_moduleroot=swine
		python_domodule *.py

		python_newexe swine.py swine
		python_newexe swinecli.py swinecli
		python_newexe swinerun.py swinerun
	}
	python_foreach_impl my_install

	dodir "usr/share/swine"
	insinto "usr/share/swine"
	doins -r images
	doicon logo/swine.png
	domenu resources/swine.desktop
	einstalldocs
}
