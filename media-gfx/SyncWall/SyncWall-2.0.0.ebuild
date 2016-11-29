# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Wallpaper manager with synchronization features"
HOMEPAGE="http://syncwall.sourceforge.net/"
SRC_URI="http://sourceforge.net/projects/syncwall/files/${PV}/${P}-src.zip"

IUSE=""
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtcore:4
	app-text/dos2unix
	x11-libs/libqxt
	media-libs/qimageblitz"

RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}-src/build

