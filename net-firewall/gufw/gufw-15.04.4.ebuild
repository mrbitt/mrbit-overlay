# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_7,3_4} )
DISTUTILS_IN_SOURCE_BUILD=1

inherit distutils-r1 versionator

MY_PN="gui-ufw"
MY_PV="$(get_version_component_range 1-2)"

DESCRIPTION="GUI frontend for managing ufw."
HOMEPAGE="https://gufw.org/"
SRC_URI="https://launchpad.net/${MY_PN}/${PN}-${MY_PV}/${MY_PV}/+download/${MY_PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="dev-python/python-distutils-extra"
RDEPEND="net-firewall/ufw
	x11-libs/gtk+[introspection]
	net-libs/webkit-gtk[introspection]
	dev-python/netifaces
	dev-python/pywebkitgtk
	sys-auth/polkit
	x11-themes/gnome-icon-theme-symbolic
"

S=${WORKDIR}/${MY_PN}-${PV}

#src_prepare() {
#	sed -i -e "s|#![ ]*/usr/bin/python$|#!/usr/bin/env python2|" \
#           -e "s|#![ ]*/usr/bin/env python$|#!/usr/bin/env python2|" \
#              $(find . -name '*.py')
#    sed -i "s|python ${LOCATIONS[${i}]}|python2 ${LOCATIONS[${i}]}|" bin/gufw
#    sed -i "s|python ${LOCATIONS[${i}]}|python2 ${LOCATIONS[${i}]}|" bin/gufw-pkexec
#}

#src_install() {
#     export XDG_RUNTIME_DIR="${S}"
#    python2 ./setup.py install --root="${D}"
#}
