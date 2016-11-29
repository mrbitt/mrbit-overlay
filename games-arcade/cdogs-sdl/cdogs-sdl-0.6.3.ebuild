# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils flag-o-matic games

#CDOGS_DATA="cdogs-data-2007-07-06"
DESCRIPTION="A port of the old DOS arcade game C-Dogs"
HOMEPAGE="http://icculus.org/cdogs-sdl/"
SRC_URI="https://github.com/cxong/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	#http://icculus.org/cdogs-sdl/files/data/${CDOGS_DATA}.tar.bz2

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="media-libs/libsdl2[video,haptic]
        media-libs/sdl2-image
        media-libs/sdl2-mixer"
RDEPEND="${DEPEND}
         net-libs/enet"

S=${WORKDIR}/${PN}-${PV}

src_prepare() {
  
  #epatch  "${FILESDIR}"/${P}-system-enet.patch || die "patch failed." 
  
  # disable -Werror (aborts build on mere warnings)
  sed 's| -Werror||' -i CMakeLists.txt  || die "sed failed."
  
  #rm -r src/cdogs/enet || die "remove enet failed."
  sed -i 's/\r//' doc/original_readme.txt
  #rm graphics/make_bullet_spritesheet.sh || die "remove spritesheet.h failed."
  #chmod -x src/tinydir/tinydir.h  || die "chnod failed."
}

src_configure() {
  
  cmake ./ -DCMAKE_INSTALL_PREFIX="/usr" -DCDOGS_DATA_DIR="/usr/share/cdogs/" -DCMAKE_BUILD_TYPE=Release
}

src_install( ) {

       ## folders
  install -d "${D}"/usr/{bin,share/{cdogs,doc}}
  install -d "${D}"/usr/local/bin
      ## binaries
  install -m755 src/cdogs-sdl{,-editor} "${D}"/usr/bin
   ln -s "${D}"/usr/bin/cdogs-sdl{,-editor} "${D}"/usr/local/bin
      ## data
  cp -rup data doc dogfights graphics missions music sounds cdogs_icon.bmp "${D}"/usr/share/cdogs
     ## doc
  ln -s /usr/share/cdogs/doc "${D}"/usr/share/doc/cdogs
  install -m644 README.md "${D}"/usr/local/share/cdogs/doc
     ## .desktop entries
  install -Dm644 build/linux/cdogs-icon.48.png "${D}"/usr/share/pixmaps/cdogs-sdl.png
  install -Dm644 build/linux/cdogs-sdl.desktop "${D}"/usr/share/applications/cdogs-sdl.desktop 
}


