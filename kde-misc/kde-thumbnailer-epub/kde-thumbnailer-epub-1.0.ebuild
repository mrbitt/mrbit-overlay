# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit cmake-utils eutils git-2

DESCRIPTION="Thumbnailer to show ePub cover previews in KDE file managers (Dolphin and Konqueror)"
HOMEPAGE="http://kde-apps.org/content/show.php/KDE+ePub+Thumbnailer?content=151210"
SRC_URI="http://kde-apps.org/CONTENT/content-files/151210-${P}.tar.gz"

LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="app-text/ebook-tools
	kde-plasma/plasma-workspace"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_unpack() {
	unpack ${A}
}	

src_configure() {
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
