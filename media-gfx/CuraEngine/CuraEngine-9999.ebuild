# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils

MY_PV=${PV/_rc/-RC}

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="git://github.com/Ultimaker/${PN}.git"
	inherit git-r3
	KEYWORDS=""
else
	SRC_URI="https://github.com/Ultimaker/${PN}/archive/${MY_PV}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A 3D model slicing engine for 3D printing"
HOMEPAGE="https://github.com/Ultimaker/CuraEngine"

LICENSE="AGPL-3"
SLOT="0"
IUSE=""

RDEPEND=""
DEPEND=""

RESTRICT="test"

S=${WORKDIR}/${PN}-${MY_PV}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-cflags.patch
}

src_install() {
	dobin build/CuraEngine
}
