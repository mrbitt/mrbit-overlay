# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
_Ver=1484423174
PYTHON_COMPAT=( python3_4 )

inherit eutils python-single-r1 toolchain-funcs

DESCRIPTION="Is a simple RPN (Reverse Polish Notation) calculator for X. It works much like an HP calculator"
HOMEPAGE="www.linux-apps.com/p/1127944/"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/${_Ver}/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/rpCalc

RDEPEND="${PYTHON_DEPS}
   	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-qt/qtwebkit:5
	dev-qt/qtcore:5"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	cd "${S}"
	dodir /usr
	./install.py -p "${D}"/usr ||  die "install failed!"

	cat <<EOF >"${D}"/usr/bin/${PN}
#!/bin/sh
exec python3 /usr/share/${PN}/${PN}.py "$@"
EOF
fperms 0755 /usr/bin/${PN}

    newicon icons/calc_lg.png  ${PN}.png||  die "doicons failed!"
	make_desktop_entry ${PN} ${PN} ${PN} "Education;Math;"
	#domenu "${FILESDIR}"/${PN}.desktop
}

