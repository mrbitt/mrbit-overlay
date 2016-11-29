# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

EGO_PN="${PN}"
	EGIT_REPO_URI="https://github.com/sadhen/${EGO_PN}.git"
	EGIT_CHECKOUT_DIR="git://github.com/sadhen/${PN}.git"
	EGIT_BRANCH="master"
	inherit eutils cmake-utils git-2

DESCRIPTION="Implementation of the Markdown markup language in CPP (library)"
HOMEPAGE="https://github.com/sadhen/libmdcpp"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""


CDEPEND=""
DEPEND="
	${CDEPEND}
	dev-libs/boost"

RDEPEND="
	${CDEPEND}"

RESTRICT="installsources strip"

S="${WORKDIR}/${P}"