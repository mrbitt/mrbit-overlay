# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

DESCRIPTION="Qt-based simple and easy to use music player designed for streaming online music and for playing files stored on your local drives"
HOMEPAGE="http://qomp.sourceforge.net/"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${PV}/${PN}_${PV}_src.tar.gz"

LICENSE="GPL"
SLOT="0"
inherit eutils kde5

KEYWORDS="amd64 x86"

RDEPEND=""
DEPEND="${RDEPEND}
    dev-qt/qtcore:5
    dev-qt/qtgui:5
    dev-qt/qtdbus:5
    dev-qt/qtmultimedia:5
    dev-qt/qtnetwork:5
    dev-qt/qtwidgets:5
    dev-qt/qtxml:5
    media-libs/libcue
    media-libs/taglib"
    
S=${WORKDIR}/${P}

