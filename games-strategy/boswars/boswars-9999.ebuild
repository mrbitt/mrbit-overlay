# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils scons-utils games subversion

ESVN_REPO_URI="svn://bos.seul.org/svn/bos/bos/trunk"

DESCRIPTION="Futuristic real-time strategy game"
HOMEPAGE="http://www.boswars.org/"
#SRC_URI="http://www.boswars.org/dist/releases/${P}-src.tar.gz"
 
LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-lang/lua
	media-libs/libsdl[sound,video]
	media-libs/libpng
	media-libs/libvorbis
	media-libs/libtheora
	media-libs/libogg
	virtual/opengl
	x11-libs/libX11
	>=games-strategy/boswars-addons-2.7"

S=${WORKDIR}/${P}-src

src_prepare() {
	rm -f doc/{README-SDL.txt,guichan-copyright.txt}
	epatch "${FILESDIR}"/${PN}-2.6.1-gentoo.patch "${FILESDIR}"/${PN}-2.6.1-scons-blows.patch
	sed -i -e "s:@GENTOO_DATADIR@:${GAMES_DATADIR}/${PN}:" engine/include/stratagus.h || die "sed stratagus.h failed"
	sed -i -e "/-O2/s:-O2.*math:${CXXFLAGS} -Wall:" SConstruct || die "sed SConstruct failed"

   #  "Fixing PNG images…"
  for _f in {maps/antarticum.map/terrain,graphics/ui/ui_*,units/{radar/*,tree*/tree0?}}.png
  do
    pngfix -e -w --out=$_f.fixed $_f || : # ignore exit code
    mv $_f.fixed $_f
  done
}

src_compile() {
	escons
}

src_install() {
	newgamesbin build/${PN}-release ${PN}
	insinto "${GAMES_DATADIR}"/${PN}
	doins -r campaigns graphics intro languages maps patches scripts \
	sounds units
	newicon "${FILESDIR}"/bos.png ${PN}.png
	make_desktop_entry ${PN} "Bos Wars"
	dodoc CHANGELOG COPYRIGHT.txt README.txt
	dohtml -r doc/*
	prepgamesdirs
}

pkg_postinst() {
	elog "----------------------------------------------------"
	elog "										              "
	elog " do not user dev-util/ccache utility , not compila  "
	elog " 			in the make.conf   						  "
	elog "  												  "
	elog "----------------------------------------------------"
}
