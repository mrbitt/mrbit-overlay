# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils versionator toolchain-funcs flag-o-matic multilib

MYPN=Ipopt

DESCRIPTION="COIN-OR Interior Point OPTimizer"
HOMEPAGE="https://projects.coin-or.org/Ipopt"
SRC_URI="http://www.coin-or.org/download/source/${MYPN}/${MYPN}-${PV}.tgz"

LICENSE="CPL-1.0"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE="+doc"

RDEPEND="
	virtual/blas
	virtual/lapack"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

S="${WORKDIR}/${MYPN}-${PV}"

src_compile() {
  cd "${MYPN}-${PV}/ThirdParty/ASL" && ./get.ASL
  cd "${MYPN}-${PV}/ThirdParty/Metis" && ./get.Metis
  cd "${MYPN}-${PV}/ThirdParty/Mumps" && ./get.Mumps
  cd "${MYPN}-${PV}"
  mkdir -p build && pushd build
}

src_install() {
	cd "${MYPN}-${PV}/build"
	make DESTDIR="${D}" install
	use doc && dodoc Ipopt/doc/documentation.pdf
}
