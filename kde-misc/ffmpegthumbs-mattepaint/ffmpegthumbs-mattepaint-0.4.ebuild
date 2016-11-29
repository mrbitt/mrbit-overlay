# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

PLOCALES="ru"
inherit cmake-utils

DESCRIPTION="Is an alternative version of the standard KDE ffmpegthumbs..."
HOMEPAGE="http://kde-apps.org/content/show.php/FFMpegThumbs-MattePaint?content=153902&PHPSESSID=680b89a1def433333e634da64102cc64"
SRC_URI="http://kde-apps.org/CONTENT/content-files/153902-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-libs/qjson
	virtual/ffmpeg"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"
