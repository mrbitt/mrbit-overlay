# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.*"

inherit distutils virtualx

DESCRIPTION="A GTK frontend for VDE and QEMU/KVM"
HOMEPAGE="http://virtualbricks.eu/"
SRC_URI="https://launchpad.net/virtualbrick/1.x/1.0.1/+download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="vde"

DEPEND=""
RDEPEND="${DEPEND}
        dev-python/twisted-conch
	dev-python/pygraphviz
	vde? ( >=net-misc/vde-2.3.2[python] )"

DOCS=""

S="${WORKDIR}/${P}"

src_prepare() {
	sed -i "s@^sys.prefix=\"/usr/local\"@sys.prefix=\"/usr\"@" \
		"${S}"/setup.py
}
