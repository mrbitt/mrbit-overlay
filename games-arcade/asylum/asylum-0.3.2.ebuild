# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils toolchain-funcs games

DESCRIPTION="2D platform game"
HOMEPAGE="http://sdl-${PN}.sourceforge.net/"
SRC_URI="http://downloads.sourceforge.net/sdl-${PN}/${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="virtual/opengl
	virtual/glu
	media-libs/sdl-mixer
	media-libs/libsdl
	media-libs/sdl-ttf
	media-libs/sdl-image"
DEPEND=${RDEPEND}

S=${WORKDIR}/${P}

src_prepare() {
  #patch -Np0 -i "${FILESDIR}"/Makefile.diff || die "patch failed"
  epatch "${FILESDIR}/Makefile.diff" || die "patch failed"
  epatch "${FILESDIR}/0001-wipealtab-bounds-check.patch" || die "patch failed"
  epatch "${FILESDIR}/0002-swi_osfile-fix-EOF-handling.patch" || die "patch failed"
  epatch "${FILESDIR}/0003-loadconfig-fix-scanf-buffer-overflow.patch" || die "patch failed"
  epatch "${FILESDIR}/0004-swi_blitz_hammerop-missing-fclose.patch" || die "patch failed"
  epatch "${FILESDIR}/0005-dropprivs-add-error-checking.patch" || die "patch failed"
}

src_install() {

  make DESTDIR="${D}" install

  install -Dm644 "${FILESDIR}"/asylum.desktop "${D}"/usr/share/applications/asylum.desktop
  install -Dm644 "${FILESDIR}"/asylum.xpm "${D}"/usr/share/pixmaps/asylum.xpm
  
  dodoc COPYING README Instruct
}
