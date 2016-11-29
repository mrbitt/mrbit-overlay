# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1 eutils

MY_P="${P/n/n}"

DESCRIPTION="GTK+ 2 rewrite of LinNeighborhood"
HOMEPAGE="http://pyneighborhood.sourceforge.net/"
SRC_URI="https://launchpad.net/${PN}/0.5/${PV}/+download/${MY_P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="net-fs/cifs-utils
	>=dev-python/pygtk-2.17
	sys-devel/gettext
	"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	 
	for file in $(find . -type f -print); do
       sed -i 's_^#!.*/usr/bin/python_#!/usr/bin/python2_' $file
       sed -i 's_^#!.*/usr/bin/env.*python_#!/usr/bin/env python2_' $file
     done
}

src_install() {
	 sed -i pyNeighborhood.desktop -e 's:Application;Network;System;Utility:Network;System;Utility:' || die
	 emake PYTHON=python2 DESTDIR="${D}"/usr install || die "emake install failed"
}
