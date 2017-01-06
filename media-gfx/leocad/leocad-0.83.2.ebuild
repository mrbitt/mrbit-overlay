# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit qt4-r2 unpacker

DESCRIPTION="LeoCAD is a CAD program that uses bricks similar to those found in many toys."
HOMEPAGE="http://www.leocad.org"
SRC_URI="https://github.com/leozide/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
         https://github.com/leozide/${PN}/releases/download/v${PV}/Library-Linux-9306.zip
         http://www.ldraw.org/library/unofficial/ldrawunf.zip"
          
          
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="jpeg zlib png +ldraw"

RDEPEND="virtual/opengl
	x11-libs/gtk+:2
	jpeg? ( virtual/jpeg )
	zlib? ( sys-libs/zlib )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_prepare() {
	
	cd "${S}"

	if ! use jpeg; then
		sed -i \
			-e "s:(test -s jpegtest); then :{(test -s jpegtest);} \&\& false; then :" \
			config.mk || die "patching Makefile failed"
	fi
	if ! use zlib; then
		sed -i \
			-e "s:(test -s ztest); then :{(test -s ztest);} \&\& false; then :" \
			config.mk || die "patching Makefile failed"
	fi
	if ! use png; then
		sed -i \
			-e "s:(test -s pngtest); then :{(test -s pngtest);} \&\& false; then :" \
			config.mk || die "patching Makefile failed"
	fi
}

src_compile() {
	cd ${S}/trunk
    eqmake4 DISABLE_UPDATE_CHECK=1
	make clean && make
}

src_install() {
    sed -i -e s/leocad.svg/leocad/g "${S}/qt/${PN}.desktop" || die
    
    make INSTALL_ROOT="${D}" install
    
    dodir /usr/share/leocad
    insinto /usr/share/leocad/
    doins "${WORKDIR}"/library.bin
 
  if use ldraw; then
    wget -P "${D}"/usr/share/leocad/ http://www.ldraw.org/library/unofficial/ldrawunf.zip || die
    #doins -r "${WORKDIR}"/{p,parts} || die
  fi
}

