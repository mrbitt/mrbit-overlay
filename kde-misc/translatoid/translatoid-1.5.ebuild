# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5

DESCRIPTION="Translator plasmoid using google translator"
HOMEPAGE="http://kde-look.org/content/show.php/translatoid?content=97511"

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="+remember debug"

if (use remember); then
	SRC_URI="http://download.ixit.cz/${PN}/${P}.tar.xz"
else
	SRC_URI="http://download.ixit.cz/${PN}/${P}-noremember.tar.xz"
fi

DEPEND="
	dev-libs/qjson
"
RDEPEND="${DEPEND}
	kde-plasma/plasma-workspace"

S="${WORKDIR}/${PN}"
