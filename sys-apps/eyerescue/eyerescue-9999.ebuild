# Copyright 2004-2013 Sabayon
# Distributed under the terms of the GNU General Public License v2
# $

EAPI=5

inherit git-2 qmake-utils

#EGIT_COMMIT="${PN}-${PV}-1"
DESCRIPTION="Is a small utility which will help to control your PC time"
HOMEPAGE="http://opendesktop.org/content/show.php/EyeRescue?content=175216"
EGIT_REPO_URI="https://github.com/adikanchukov/EyeRescue"
EGIT_PROJECT=EyeRescue

LICENSE="GPL"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="+qt5"
REQUIRED_USE="qt5"

RDEPEND="${DEPEND}
		dev-qt/qtwidgets:5
		dev-qt/qtgui:5
		dev-qt/qtcore:5
		dev-qt/qtsvg:5
		dev-qt/qtscript:5 "
DEPEND="${DEPEND}"

DOCS="README.md"

S=${WORKDIR}/eyerescue

src_compile() {
	eqmake5 EyeRescue.pro -r
	emake
}

src_install() {
	dobin EyeRescue
	newicon etc/logo.png EyeRescue.ico
	make_desktop_entry EyeRescue EyeRescue EyeRescue System
}
