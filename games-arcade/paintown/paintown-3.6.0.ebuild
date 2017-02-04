# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit cmake-utils games

DESCRIPTION="Side-scrolling beat-em-up in the style of Beats of Rage"
HOMEPAGE="http://paintown.sourceforge.net/"
SRC_URI="https://sourceforge.net/projects/${PN}/files/${PN}/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="allegro +sdl"

RDEPEND="
   allegro? (
       >=media-libs/allegro-4.1
       media-libs/aldumb )
   sdl? (
       media-libs/libsdl:0
       media-libs/libogg
       media-libs/libvorbis
       media-sound/mpg123 )
       "
DEPEND="${RDEPEND}
    media-libs/libmad:0
    dev-lang/python:2.7
    sys-libs/zlib
    media-libs/freetype
    dev-util/scons
    media-libs/libpng
	dev-util/cmake"

dir=${GAMES_DATADIR}/${PN}

src_configure() {
	sed -i '1i#define OF(x) x' `find -name ioapi.h`
	sed -i '1i#define OF(x) x' `find -name unzip.h`
	
	append-cppflags -lfreetype
	if  use allegro ; then
	  local mycmakeargs=(
		-DFREETYPE_INCLUDE_DIR=/usr/include/freetype2 #/usr/bin/freetype-config --cflags
		-DBASE_SRC=${GAMES_DATADIR}"/${PN}/data/"
		-DUSE_SDL=OFF
		-DUSE_ALLEGRO5=ON )
     else 
       local mycmakeargs=(
           -DFREETYPE_INCLUDE_DIR=/usr/include/freetype2 #/usr/bin/freetype-config --cflags
           -DBASE_SRC=${GAMES_DATADIR}"/${PN}/data/"
           -DUSE_SDL=ON
           -DUSE_ALLEGRO5=OFF )
      fi     
	cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile
}

src_install() {
		
	insinto ${GAMES_DATADIR}/${P}
	doins -r ${WORKDIR}/${P}_build/bin/${PN} data
	fperms 0755 ${GAMES_DATADIR}/${P}/${PN}
	
	insinto /usr/bin
	cat <<EOF >"${D}"/usr/bin/${PN}
#!/bin/sh
${GAMES_DATADIR}/${P}/${PN} -d ${GAMES_DATADIR}/${P}/data 
EOF
  
  fperms 0755 /usr/bin/${PN}

	newicon misc/icon.png ${PN} || die
	
	sed -i -e s/Application//g misc/${PN}.desktop || die
	sed -i -e s/${PN}.png/${PN}/g misc/${PN}.desktop || die
	domenu misc/${PN}.desktop || die
	DOCS="README LEGAL doc/* TODO" 
	prepgamesdirs
}
