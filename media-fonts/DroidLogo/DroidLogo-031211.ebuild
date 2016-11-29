# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit font

DESCRIPTION="A Android Logo truetype fonts"
HOMEPAGE="http://www.android-hilfe.de/thema/geloest-android-font.15625"
SRC_URI="http://www.android-hilfe.de/attachments/droidlogo_font_031211-zip.72942 -> ${PN}_Font_031211.zip"

LICENSE=""
SLOT="0"
KEYWORDS="alpha amd64 arm ia64 ppc ~ppc64 s390 sh sparc x86 ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"
IUSE=""

FONT_SUFFIX="ttf"
FONT_S="${WORKDIR}"

S=${FONT_S}
