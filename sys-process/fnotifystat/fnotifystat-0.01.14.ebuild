# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools

DESCRIPTION="File activity monitoring tool"
HOMEPAGE="https://launchpad.net/ubuntu/wily/+source/fnotifystat"
SRC_URI="https://launchpad.net/ubuntu/+archive/primary/+files/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


CDEPEND=""
DEPEND=""

RDEPEND="
	${CDEPEND}"

RESTRICT="installsources strip"

S="${WORKDIR}/${P}"