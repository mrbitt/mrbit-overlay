# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
PYTHON_COMPAT=( python2_7 )

inherit python-single-r1

DESCRIPTION="Python implementation for the .NET framework"
HOMEPAGE="http://ironpython.net"
SRC_URI="https://github.com/IronLanguages/main/archive/${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86 ~amd64-linux ~x86-linux"
IUSE="test"

CDEPEND="
	>=dev-python/pbr-1.8[${PYTHON_USEDEP}]
"
CRDEPEND=""
DEPEND="
	dev-lang/mono
	dev-python/setuptools[${PYTHON_USEDEP}]
"
RDEPEND="
	${CDEPEND}
	${CRDEPEND}
"
S=${WORKDIR}/main-${P}

pkg_setup() {
	python-single-r1_pkg_setup
}

src_prepare() {
	sed -i "/NoWarn/s|444;||" Solutions/Common.proj || die
	sed -i -e "s:FEATURE_IPV6::" Solutions/Common.proj || die
   xbuild Solutions/IronPython.sln /p:Mono=true /p:Configuration="Release"	|| die	
}


src_install() {
   
mkdir -p "${D}/opt/ipy" "${D}/usr/bin"
  cp -r ${S}/${PN}/bin/Release/* "${D}/opt/ipy"
  for bin in ipy ipy64 ipyw ipyw64; do
    echo -e "#!/bin/sh\nmono /opt/ipy/$bin.exe $*" > "${D}/usr/bin/$bin"
    chmod +x "${D}/usr/bin/$bin"
  done
}
