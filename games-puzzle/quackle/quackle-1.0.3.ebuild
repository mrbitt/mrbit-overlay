# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils kde4-base qt4-r2 games

DESCRIPTION="Free crossword game (Scrabble-like) artificial intelligence and analysis tool"
HOMEPAGE="http://people.csail.mit.edu/jasonkb/quackle"
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL"
SLOT="4"
KEYWORDS="amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:4"

RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_configure() {
    for dir in "" quackleio quacker; do
     cd "${S}/${dir}"
     eqmake4
     make clean
     make
  done
}

src_install() {
    cd "${S}"
  install -dm755 ${D}usr/share/${PN}
  cp -r quacker/Quackle data ${D}/usr/share/${PN}
  
  games_make_wrapper ${PN} "./Quackle" "/usr/share/${PN}"
  
  newicon -s 48 IconSmall.png ${PN}.png
  make_desktop_entry ${PN} ${PN} ${PN} Game

  dodoc LICENSE README.md
  
  prepgamesdirs
    
}
