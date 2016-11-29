# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

if [[ ${PV} = 9999* ]]; then
	EGIT_REPO_URI="git://github.com/daid/${PN}.git"
	inherit git-r3
else
	SRC_URI="https://github.com/daid/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="A mesh slicer written in python to produce gcode for 3D printers"
HOMEPAGE="https://github.com/daid/Cura"

LICENSE="AGPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	dev-python/wxpython[${PYTHON_USEDEP}]
	>=dev-python/numpy-1.6.2[${PYTHON_USEDEP}]
	>=dev-python/pyopengl-3.0.2[${PYTHON_USEDEP}]
	>=dev-python/pyserial-2.6[${PYTHON_USEDEP}]
	>=dev-python/setuptools-0.6.34[${PYTHON_USEDEP}]
	>=media-gfx/CuraEngine-${PV}
"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQ_USE}"

src_prepare() {
	epatch "${FILESDIR}"/${PN}-nopower.patch
}

src_install() {
	insinto /usr/share/cura
	doins -r Cura resources plugins scripts/linux/cura.py
	echo ${PV} >"${ED}"usr/share/cura/version
	cat >"${T}"/cura <<CURAEOF
#!/bin/sh
PYTHONPATH="\$PYTHONPATH:${EROOT}usr/share/cura/" /usr/bin/python2 ${EROOT}usr/share/cura/cura.py "\$@"
CURAEOF
	dobin "${T}"/cura

	make_desktop_entry cura \
		Cura \
		/usr/share/cura/resources/images/c.png \
		"Graphics;3DGraphics;Engineering;Development"
}
