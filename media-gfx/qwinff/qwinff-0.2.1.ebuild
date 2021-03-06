# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="another frontend QT for ffmpeg"
HOMEPAGE="https://code.google.com/p/qwinff/"
SRC_URI="http://sourceforge.net/projects/${PN}/files/release/v${PV}/${PN}_${PV}.tar.bz2"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND="kde-frameworks/oxygen-icons"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    media-sound/sox
    >=media-video/ffmpeg-1
    >=kde-frameworks/kdelibs-4.4"
    
S=${WORKDIR}/${PN}-${PV}


