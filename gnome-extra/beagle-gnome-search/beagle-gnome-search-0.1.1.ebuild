# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{3_4,3_5} ) 

inherit eutils distutils-r1

DESCRIPTION="A search tool for GNOME, written in Python3 and Gtk3."
HOMEPAGE="https://github.com/vinsce/beagle-gnome-search"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1481200473/{PN}.tar.xz -> ${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 amd64"

COMMON_DEPEND="
	${PYTHON_DEPS}
	dev-python/pexpect[${PYTHON_USEDEP}]
	dev-python/pygobject:3[${PYTHON_USEDEP}]
	x11-libs/gtk+:3[introspection]
"
RDEPEND="
	${COMMON_DEPEND}
	virtual/freedesktop-icon-theme
"
DEPEND="
	${COMMON_DEPEND}
	sys-devel/gettext
"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

S="${WORKDIR}"

src_compile(){
     nop
}

src_install () {
	
	# Create /usr/share/doc,beagle-gnome-search and copy source,res
	dodir /usr/share/${PN}
	dodoc README.md
    insinto /usr/share/${PN}
	doins -r "${S}"/{source,res}/
		
	# Create /usr/bin/beagle-gnome-search
	dodir /usr/bin/
	cat <<EOF >"${D}"/usr/bin/${PN}
#!/bin/sh
python3 /usr/share/${PN}/source/app.py
EOF
    fperms 0755 /usr/bin/${PN}

    #doicon "${FILESDIR}"/${PN}.xpm
	#domenu "${FILESDIR}"/${PN}.desktop
}
