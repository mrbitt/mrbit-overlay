# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Astronomical world map that shows day and night and the Sun and Moon positions"
HOMEPAGE="https://github.com/mdoege/Sunclock"
SRC_URI="https://github.com/mdoege/Sunclock/archive/master.zip -> ${P}.zip"
    
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libjpeg-turbo
	     media-libs/libpng
	     x11-libs/libXpm
	     x11-misc/imake"

S="${WORKDIR}"/Sunclock-master/${P}

src_prepare() {
	       cd ..
	       tar xjf medium_images_270804.tar.bz2  || die "tar failed"
           tar xjf big_images_270804.tar.bz2 || die "tar failed"
	       sed -i "s_/share/sunclock/bin_/bin_" sunclock-3.57/Imakefile || die "sed failed"
	       epatch "${FILESDIR}"/disable_zlib.patch || die "patch failed"
}

src_configure() {
			xmkmf
			make
}

src_install() {
	
  # Install program files
  cd "${S}"
  make DESTDIR="${D}" \
       BINDIR=/usr/bin \
       EMXBINDIR=/usr/bin \
       SHAREDIR=/usr/share/${PN} \
       MANDIR=/usr/share/man/man1 install

  # Install data files
  mkdir -p "${D}/usr/share/${PN}/earthmaps/jpeg"
  install -m644 ../images/medium/*.jpg ../huge.jpg "${D}/usr/share/${PN}/earthmaps/jpeg"
  install -m644 ../images/big/*.jpg "${D}/usr/share/${PN}/earthmaps/jpeg"
  install -Dm644 README "${D}/usr/share/doc/sunclock/README"

  # Install a desktop entry
  install -Dm644 wm_icons/sunclock2.xpm "${D}/usr/share/pixmaps/${PN}.xpm"
  install -Dm644 "${FILESDIR}"/${PN}.desktop "${D}/usr/share/applications/${PN}.desktop"	
}	
