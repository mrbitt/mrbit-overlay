# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/games-arcade/fishsupper/fishsupper-0.1.6.ebuild,v 1.5 2013/02/07 22:04:38 ulm Exp $

EAPI=2
inherit eutils autotools games

DESCRIPTION="Is a tile-based, cross-platform 2D racing game written in Qt (C++) and OpenGl."
HOMEPAGE="http://juzzlin.github.io/DustRacing2D/"
#SRC_URI="http://netcologne.dl.sourceforge.net/project/${PN}/src/${PN}-${PV}.tar.gz"
SRC_URI="http://ftp.twaren.net/FreeBSD/ports/distfiles/${PN}-${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="
	virtual/opengl"
DEPEND="${RDEPEND}
	media-libs/glu
	media-libs/openal
	dev-qt/qtcore:5"

#src_prepare() {
#	epatch "${FILESDIR}"/${P}-ovflfix.patch \
#		"${FILESDIR}"/${P}-asneeded.patch
#	eautoreconf
#}
S=${WORKDIR}/${PN}-${PV}

src_configure() {
	cd "${S}"
	#./configure -DReleaseBuild=1 -DCMAKE_INSTALL_PREFIX=/usr
	qmake ${PN}.pro
	make
}

src_install() {
	cd "${S}"
	emake DESTDIR="${D}" install || die
	mkdir "${D}"/usr/bin
	mv "${D}"/usr/"${PN}"-{editor,game} "${D}"/usr/bin/
	mv "${D}"/usr/{AUTHORS,CHANGELOG,COPYING,README} "${D}"/usr/data/
	mkdir "${D}"/usr/share/games && mkdir "${D}"/usr/share/games/DustRacing
	mv  "${D}"/usr/data "${D}"/usr/share/games/DustRacing
#	dodoc AUTHORS README

#	newicon data/images/fs_sprite_042.png ${PN}.png
#	make_desktop_entry ${PN} "Fish Supper"

#	prepgamesdirs
}
