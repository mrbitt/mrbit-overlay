# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
PYTHON_COMPAT=( python2_7 )
inherit eutils multilib python-r1

DESCRIPTION="Disper is an on-the-fly display switch utility"
HOMEPAGE="http://willem.engen.nl/projects/disper/"
#SRC_URI="http://ppa.launchpad.net/wvengen/ppa/ubuntu/pool/main/d/${PN}/${PN}_${PV}.tar.gz"
SRC_URI="http://ppa.launchpad.net/disper-dev/ppa/ubuntu/pool/main/d/${PN}/${PN}_${PV}.tar.gz"
RESTRICT="mirror"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE=""

DEPEND="dev-lang/python"
RDEPEND="${DEPEND}"

#S="${WORKDIR}/trunk"
S="${WORKDIR}/${PN}"

src_prepare() {
	# Patch to use python2
    sed -i -e 's|`src/disper.py|`python2 src/disper.py|' Makefile || die "sed failed."
    
    # Patch PREFIX
   sed -i -e 's|PREFIX =.*|PREFIX = /usr|' Makefile

}

src_install() {
	emake DESTDIR="${D}" install
	doman "${PN}.1"
	dodoc README
	
	# Patch to use python2
  find "${D}" -type f \( -name '*.py' -or -executable \) -exec \
    sed -i -e "s|#![ ]*/usr/bin/python$|#!/usr/bin/python2|" \
           -e "s|#![ ]*/usr/bin/env python$|#!/usr/bin/env python2|" \
    \{\} +
}
