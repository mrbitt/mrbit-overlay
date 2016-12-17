# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

DESCRIPTION=" is an open source ORM (Object Relational Mapping) C++ database library designed to provide"
HOMEPAGE="http://www.qxorm.com/"
SRC_URI="http://www.qxorm.com/version/${PN}_${PV}.zip"

LICENSE="GPL-v3"
SLOT="0"

inherit eutils kde5

KEYWORDS="amd64 x86"

RDEPEND=""
DEPEND="${RDEPEND}
    dev-qt/qtcore:5
    dev-qt/qtsql:5"
    
S=${WORKDIR}/${PN}
