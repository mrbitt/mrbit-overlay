# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
MY_PN=${PN/-addons/}

inherit eutils games

DESCRIPTION="Futuristic real-time strategy game"
HOMEPAGE="http://www.boswars.org/"
#SRC_URI="http://www.boswars.org/dist/releases/${P}-src.tar.gz"
SRC_URI="http://www.boswars.org/addons/greenlands.map.tgz
        http://www.boswars.org/addons/obese.map.tgz
	    http://www.boswars.org/addons/obese2.map.tgz
        http://www.boswars.org/addons/wargrounds.map.tgz
        http://www.boswars.org/addons/wetlands03.map.tgz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}

src_install() {
	insinto "${GAMES_DATADIR}"/${MY_PN}/maps
	doins -r *.*
	prepgamesdirs
}
