# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit qmake-utils unpacker

DESCRIPTION="LeoCAD is a CAD program that uses bricks similar to those found in many toys."
HOMEPAGE="http://www.leocad.org"
SRC_URI="https://github.com/leozide/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz
         https://github.com/leozide/${PN}/releases/download/v${PV}/Library-Linux-9781.zip"
         #http://www.ldraw.org/library/unofficial/ldrawunf.zip"
          
          
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="qt4 +qt5 jpeg zlib png +ldraw"
REQUIRED_USE="^^ ( qt4 qt5 )"

RDEPEND="
    qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		)
    virtual/opengl
	x11-libs/gtk+:2
	jpeg? ( virtual/jpeg )
	zlib? ( sys-libs/zlib )
	ldraw? ( media-libs/ldraw )
	png? ( media-libs/libpng )"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_prepare() {
	
	cd "${S}"
    default 
    
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
	#cd ${S}/trunk
    use qt4 && eqmake4 LDRAW_LIBRARY_PATH=/usr/share/ldraw DISABLE_UPDATE_CHECK=1
	use qt5 && eqmake5 INSTALL_PREFIX=/usr DISABLE_UPDATE_CHECK=1 LDRAW_LIBRARY_PATH=/usr/share/leocad
	make clean && make
}

src_install() {
    sed -i -e s/leocad.svg/leocad/g "${S}/qt/${PN}.desktop" || die
    
    make INSTALL_ROOT="${D}" install
    
    dodir /usr/share/leocad
    insinto /usr/share/leocad/
    doins "${WORKDIR}"/library.bin
 
  #if use unofficial; then
    #wget -P "${D}"/usr/share/ldraw/ http://www.ldraw.org/library/unofficial/ldrawunf.zip || die
   #doins -r "${WORKDIR}"/{p,parts} || die
  #fi
}

