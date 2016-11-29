# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python{2_7,3_{4,5}} pypy{,3} )
inherit eutils distutils-r1

DESCRIPTION="A geolocation OSINT tool"
HOMEPAGE="http://www.geocreepy.com/"
SRC_URI="https://github.com/jkakavas/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="~x86 amd64"

RDEPEND="dev-python/beautifulsoup[${PYTHON_USEDEP}]
		 dev-python/flickr-api
		 dev-python/python-instagram[${PYTHON_USEDEP}]
		 dev-python/simplejson[${PYTHON_USEDEP}]
		 dev-python/pyexiv2
		 dev-python/yapsy[${PYTHON_USEDEP}]
		 dev-python/configobj[${PYTHON_USEDEP}]
		 dev-python/oauth2client[${PYTHON_USEDEP}]
		 dev-python/tweepy[${PYTHON_USEDEP}]
		 dev-python/PyQt4[${PYTHON_USEDEP}]
		 dev-python/dominate[${PYTHON_USEDEP}]
		 dev-python/pytz[${PYTHON_USEDEP}]
		 dev-python/python-dateutil[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P}"

DOCS=( README.md  LICENSE)

src_prepare() {
		
		find . -name '*.pyc' -delete
		
		epatch "${FILESDIR}"/05-project-dir.patch || die "sed failed."
		epatch "${FILESDIR}"/06-linux-setup-py.patch || die "sed failed."
		epatch "${FILESDIR}"/07-use-getplugindirs.patch || die "sed failed."
		epatch "${FILESDIR}"/08-local-config.patch || die "sed failed."
		epatch "${FILESDIR}"/09-ratebutton-disable.patch || die "sed failed."
		epatch "${FILESDIR}"/10-unused-configobj.patch || die "sed failed."
}

python_compile() {
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing -lrt"
	distutils-r1_python_compile
}
src_install () {
	
	dodir /usr/share/
    insinto /usr/share
	doins -r "${S}"/${PN}

	doicon "${FILESDIR}"/${PN}.xpm
	
	domenu "${FILESDIR}"/${PN}.desktop
	
	dosym /usr/share/${PN}/CreepyMain.py /usr/bin/${PN}
	chmod 755 ${D}//usr/share/creepy/CreepyMain.py
	
	# Patch to use python2
  find "${D}" -type f \( -name '*.py' -or -executable \) -exec \
    sed -i -e "s|#![ ]*/usr/bin/python$|#!/usr/bin/python2|" \
           -e "s|#![ ]*/usr/bin/env python$|#!/usr/bin/env python2|" \
    \{\} +
 
}
