# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Another image Viewer and Organizer"
HOMEPAGE="http://oferkv.github.io/phototonic/"
SRC_URI="https://github.com/oferkv/phototonic/archive/v${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=media-video/ffmpeg-1
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${P}

src_prepare() {
	sed -i -e 's:svg+xml:svg+xml;:'  ${PN}.desktop || die
	sed -i -e '10d' ${PN}.desktop || die "sed failed"
}
