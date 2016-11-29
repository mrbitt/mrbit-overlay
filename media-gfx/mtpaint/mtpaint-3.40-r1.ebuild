# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils base

DESCRIPTION="Simple gtk+ painting program"
HOMEPAGE="http://mtpaint.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="gif jpeg tiff"

DEPEND="
	>=sys-libs/zlib-1.2.1
	>=media-libs/libpng-1.2.7
	>=sys-devel/gettext-0.14.1
	>=dev-libs/glib-2.6.4:2
	>=x11-libs/gtk+-2.6.4:2
	>=x11-libs/pango-1.8.0
	gif? ( >=media-libs/giflib-4.1.4 )
	jpeg? ( virtual/jpeg )
	tiff? ( >=media-libs/tiff-3.6.1 )"

RDEPEND="${DEPEND}"

DOCS=("README" "NEWS")

src_prepare() {
	epatch "${FILESDIR}/${PN}-libpng14.patch"
	sed -i configure \
	    -e 's:LDFLAGS="-s:LDFLAGS=":g' \
	    || die "sed failed"
	sed -i doc/${PN}.desktop \
	    -e '/Encoding/d' \
	    || die "sed failed"

      	  # Needed for giflib 5. Not needed for mtpaint>3.40.
  sed -i 's:EGifOpenFileName(file_name, FALSE):EGifOpenFileName(file_name, FALSE, NULL):' src/png.c || die "sed failed"
  sed -i 's:DGifOpenFileName(file_name):DGifOpenFileName(file_name, NULL):g' src/png.c || die "sed failed"
  
  sed -i 's:DGifCloseFile(giffy):DGifCloseFile(giffy, NULL):g' src/png.c || die "sed failed"
  sed -i 's:EGifCloseFile(giffy):EGifCloseFile(giffy, NULL):g' src/png.c || die "sed failed"
  
  sed -i 's:MakeMapObject(:GifMakeMapObject(:g' src/png.c || die "sed failed"
  sed -i 's:FreeMapObject(:GifFreeMapObject(:g' src/png.c || die "sed failed" 
}

src_configure() {
	local myconf

	myconf="${myconf} --prefix=/usr"

	# build international version
	myconf="${myconf} intl --locale=/usr/share/locale"
	# build manuals
	myconf="${myconf} man --mandir=/usr/share/man"

	if use gif ; then
		myconf="${myconf} GIF"
	else
		myconf="${myconf} nogif"
	fi

	if use jpeg ; then
		myconf="${myconf} jpeg"
	else
		myconf="${myconf} nojpeg"
	fi

	if use tiff ; then
		myconf="${myconf} tiff"
	else
		myconf="${myconf} notiff"
	fi

	myconf="${myconf} cflags gtk2"

	# run configure
	./configure ${myconf} || die "configure failed"
}
