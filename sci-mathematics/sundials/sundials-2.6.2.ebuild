# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-strategy/hedgewars/hedgewars-0.9.20.ebuild,v 1.1 2013/12/25 17:52:05 hasufell Exp $

# TODO: when physfs-2.1.0 hits the tree, set
# -DPHYSFS_SYSTEM=ON

EAPI=5
CMAKE_BUILD_TYPE=Release
inherit cmake-utils eutils

DESCRIPTION="Suite of nonlinear differential/algebraic equation solvers"
HOMEPAGE="https://computation.llnl.gov/casc/sundials/main.html"
SRC_URI="http://pkgs.fedoraproject.org/repo/extras/${PN}/${P}.tar.gz/3deeb0ede9f514184c6bd83ecab77d95/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_configure() {
	cmake-utils_src_configure
}