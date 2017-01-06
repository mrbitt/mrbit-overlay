# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

_ID=1483687623

DESCRIPTION="The classic Japanese game of Soko-Ban"
HOMEPAGE="https://www.linux-apps.com/p/1109295"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/${_ID}/${P}.tgz"

SLOT="0"

inherit eutils games

KEYWORDS="amd64 ~mips x86"

RDEPEND=""
DEPEND="${RDEPEND}
    dev-qt/qtcore:4"
    
S=${WORKDIR}/${PN}
RESTRICT="strip"

	
src_install() {
	#dodir /home/$SUDO_USER/${PN}
	
	#sed -i -e s/username/$SUDO_USER/g "${S}/sokoban.desktop" || die
	#cp -pPR "${WORKDIR}"/*  "${D}"/home/$SUDO_USER || die "copying files failed!"
        
    prepgamesdirs
    dodir /usr/{bin,share/{,SokobanSG,applications}}
    cp "${S}"/Sokoban "${D}"/usr/bin 
    fperms +x /usr/bin/Sokoban || die "perms install failed"
    #cp -rup levels skins "${D}"/home/$SUDO_USER/SokobanSG || die "cp failed"
    #sed -i -e s/username/$SUDO_USER/g "${S}/sokoban.desktop" || die
    
    cp -rup levels skins "${D}"/usr/share/SokobanSG || die "cp failed"
    cd "${D}"/usr/share/SokobanSG/levels
    find . -type f -name "*.*" -exec fperms +rx '{}' +
    cd "${D}"/usr/share/SokobanSG/skins
    find . -type f -name "*.*" -exec fperms +rx '{}' +
    
    cd "${S}"
    newicon sokoban.png sokoban.png || die "icon install failed"
       ##make_desktop_entry Sokoban Sokoban sokoban  || die "desktop install failed"
    install -Dm644 "${FILESDIR}"/Sokoban.desktop "${D}"/usr/share/applications/  || die "install failed"

	 ## add path
    ##sed '5 i Path=/usr/share/Sokoban' "${D}"/usr/share/applications/Sokoban-SokobanSG.desktop || die "sed failed"
}
