# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="Map editor for the classic DOOM games, and a few related games such as Heretic and Hexen."
HOMEPAGE="http://eureka-editor.sourceforge.net/"
SRC_URI="https://sourceforge.net/projects/eureka-editor/files/Eureka/1.21/${P}-source.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S=${WORKDIR}/${PN}-1.21-source

DEPEND=">=x11-libs/fltk-1.3.0
	sys-libs/zlib"

src_prepare() {
	eapply "${FILESDIR}"/${P}-gentoo-makefile.patch

	eapply_user
	   
	mkdir -p "${D}"/usr/bin
}

src_install() {
			mkdir -p "${D}"/usr/bin
			emake PREFIX="${D}usr" install
			
			doicon misc/${PN}.xpm  || die "icon install failed"
            insinto /usr/share/applications
	        doins misc/${PN}.desktop || die "install desktop file failed"
}
