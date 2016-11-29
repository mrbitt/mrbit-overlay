# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit cmake-utils eutils

DESCRIPTION="A barcode encoding library supporting over 50 symbologies."
HOMEPAGE="http://sourceforge.net/projects/zint/"
SRC_URI="http://sourceforge.net/projects/${PN}/files/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtcore
	dev-qt/qtgui:4
	dev-libs/openssl
	x11-libs/libXext
	sys-libs/zlib"
DEPEND="${RDEPEND}"



src_configure() {
	cmake-utils_src_configure
}

src_install() {
         cmake-utils_src_install
    ln ${D}/usr/lib64/libQZint.so.2.4.1 ${D}/usr/lib64/libQtZint.so.1
}