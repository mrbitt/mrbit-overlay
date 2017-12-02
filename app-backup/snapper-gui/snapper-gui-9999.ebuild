# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
#PYTHON_COMPAT=( python{3_3,3_4} )
EGIT_REPO_URI="git://github.com/ricardo-vieira/${PN}.git"
EGIT_BRANCH="qt_port" 
inherit  eutils git-2 qmake-utils

DESCRIPTION="Python bindings for Network Security Services (NSS)"
HOMEPAGE="https://github.com/ricardomv/${PN}"
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtwidgets:5
	dev-qt/qtgui:5
	dev-qt/qtdeclarative:5
	dev-qt/qtcore:5
	dev-qt/qtquickcontrols:5
	sys-fs/cryptsetup"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${PN}

#python_compile() {
#	python_is_python3
#	distutils-r1_python_compile
#}

src_compile() {
	cd ${P}
	eqmake5 ${PN}.pro
	make
}

src_install() {
	dobin ${PN}
	make_desktop_entry ${PN} ${PN} ${PN} System;
	#emake install INSTALL_ROOT="${D}"
}
