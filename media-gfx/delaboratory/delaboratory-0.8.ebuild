# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/pencil/pencil-0.4.4_beta.ebuild,v 1.4 2013/03/02 21:38:40 hwoarang Exp $

EAPI=2
inherit eutils qt4-r2 multilib unpacker

#MY_P=${P/_beta/b}

DESCRIPTION="A realtime color correction utility"
HOMEPAGE="http://code.google.com/p/delaboratory/"
SRC_URI="http://${PN}.googlecode.com/files/${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="x11-libs/wxGTK
	dev-util/desktop-file-utils"
DEPEND="${RDEPEND}
	media-libs/tiff
	dev-libs/libxml2"

#S=${WORKDIR}/${MY_P}-source
RESTRICT="strip"

#src_prepare() {
#	econf \
#	--libdir=/usr/$(get_libdir)

#	emake || die
#	#epatch "${FILESDIR}"/${P}-gcc461.patch
#	sed -i s:SWFSprite:SWFMovieClip:g src/external/flash/flash.{cpp,h} || die
#}

src_compile() {
	ARCH=`uname -m`
    if [ $ARCH = "x86_64" ] 
       then
	   make OPTFLAGS=-march=64 OPTFLAGS=-march=core2
    fi
	make
}

src_install() {
	# install target not yet provided
	#emake INSTALL_ROOT="${D}" install || die "emake install failed"
	#cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
	#dodir /usr/lib64
	#ln /usr/lib64/libpng.so ${D}/usr/lib64/libpng12.so.0
	#ln /usr/lib64/libming.so.1 ${D}/opt/pencil/lib/libming.so.1
	newbin delaboratory ${PN} || die "dobin failed"

	#dodoc README TODO || die

	#mv "${S}"/icons/icon.png "${S}"/icons/${PN}.png
	#doicon "${S}"/icons/${PN}.png || die "doicon failed"
	make_desktop_entry ${PN} delaboratory ${PN} Graphics
	
}
