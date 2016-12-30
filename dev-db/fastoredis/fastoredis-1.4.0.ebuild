# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit multilib unpacker

DESCRIPTION="FastoRedis (fork of FastoNoSQL) — is a database cross-platform open source Redis management tool"
HOMEPAGE="www.fastoredis.com"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1483084363/${P}-x86_64.deb"
	
LICENSE="GPL-v3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-libs/libstdc++-v3-3.3.6-r1"
DEPEND="${RDEPEND}
        >=dev-qt/qtcore-5.4.0:5
		>=dev-qt/qtgui-5.4.0:5
		>=dev-qt/qtwebkit-5.4.0:5"

S=${WORKDIR}

#RESTRICT="strip"

src_install() {
	
    sed -i '3s|Exec=fastoredis|Exec=fastoredis.sh|g' "${S}/opt/${PN}/share/applications/${PN}.desktop" || die
	sed -i '7s|Icon=fastoredis.png|Icon=fastoredis|g' "${S}/opt/${PN}/share/applications/${PN}.desktop" || die
	sed -i '9s|IDE;redis;|IDE;|g' "${S}/opt/${PN}/share/applications/${PN}.desktop" || die
	
	dodir /usr/{bin,share}  
	mv "${S}"/opt/${PN}/{bin,share}  "${D}"/usr/
	
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
	
}
