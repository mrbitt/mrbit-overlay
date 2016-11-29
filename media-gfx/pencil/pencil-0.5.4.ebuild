# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pencil/pencil-0.4.4_beta.ebuild,v 1.4 2013/03/02 21:38:40 hwoarang Exp $

EAPI=5
inherit eutils qt4-r2 multilib unpacker

#MY_P=${P/_beta/b}

DESCRIPTION="A Qt4 based animation and drawing program"
HOMEPAGE="http://www.pencil-animation.org/"
SRC_URI="http://download.tuxfamily.org/morevna/morevnapackage/binaries/${PN}/${PN}2d_${PV}-20130728.1_amd64.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-qt/qtgui:4
	dev-qt/qtopengl:4
	>=media-libs/ming-0.4.3"
DEPEND="${RDEPEND}
	app-arch/unzip
	app-arch/dpkg"

S=${WORKDIR}
RESTRICT="strip"
#src_prepare() {
#	#epatch "${FILESDIR}"/${P}-gcc461.patch
#	sed -i s:SWFSprite:SWFMovieClip:g src/external/flash/flash.{cpp,h} || die
#}

src_install() {
	# install target not yet provided
	#emake INSTALL_ROOT="${D}" install || die "emake install failed"
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
	dodir /usr/lib64
	ln /usr/lib64/libpng.so ${D}/usr/lib64/libpng12.so.0
	#newbin Pencil ${PN} || die "dobin failed"

	#dodoc README TODO || die

	#mv "${S}"/icons/icon.png "${S}"/icons/${PN}.png
	#doicon "${S}"/icons/${PN}.png || die "doicon failed"
	#make_desktop_entry ${PN} Pencil ${PN} Graphics
}
