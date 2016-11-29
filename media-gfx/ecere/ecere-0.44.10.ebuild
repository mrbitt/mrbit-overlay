# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-admin/packagekit-gtk/packagekit-gtk-0.8.15.ebuild,v 1.3 2013/12/24 10:54:15 lxnay Exp $

EAPI="4"

inherit eutils qt4-r2

DESCRIPTION="The Ecere SDK is a cross-platform toolkit for building software applications Opengl"
HOMEPAGE="http://www.ecere.com/"
SRC_URI="http://github.com/ecere/ecere-sdk/archive/${PV}.tar.gz -> ${PN}-sdk-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-libs/libpng
	 >=media-libs/freetype-2.4
	 sys-libs/ncurses
	 media-libs/giflib
	 media-libs/libjpeg-turbo
	 sys-libs/zlib
	 media-libs/fontconfig
	 x11-libs/libXext
	 x11-libs/libXrender
	 media-libs/mesa
	 media-fonts/libertine-ttf
	 media-fonts/ttf-bitstream-vera
	 dev-libs/libffi
	 dev-lisp/ecls"
	 
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}-sdk-${PV}"

src_prepare() {
	sed -i '18s|CFLAGS =|CFLAGS = -lncurses -ltinfo|g' "${S}"/ecere/Makefile || die "sed failed"
	sed -i '19s|LDFLAGS =|LDFLAGS = -lncurses -ltinfo|g' "${S}"/ecere/Makefile || die "sed failed"
	sed -i '18s|CFLAGS =|CFLAGS = -lncurses -ltinfo|g' "${S}"/ecere/Makefile.vanilla || die "sed failed"
	sed -i '19s|LDFLAGS =|LDFLAGS = -lncurses -ltinfo|g' "${S}"/ecere/Makefile.vanilla || die "sed failed"
	sed -i '17s|CFLAGS =|CFLAGS = -lncurses -ltinfo|g' "${S}"/compiler/ecp/Makefile || die "sed failed"
	sed -i '18s|LDFLAGS =|LDFLAGS = -lncurses -ltinfo|g' "${S}"/compiler/ecp/Makefile || die "sed failed"
	sed -i '17s|CFLAGS =|CFLAGS = -lncurses -ltinfo|g' "${S}"/ear/extract/Makefile || die "sed failed"
	sed -i '18s|LDFLAGS =|LDFLAGS = -lncurses -ltinfo|g' "${S}"/ear/extract/Makefile || die "sed failed"
	sed -i '8s|#include "ffi.h"|#include "ecl/ffi.h"|g' "${S}"/eda/libeda/src/EDA.ec || die "sed failed"
	sed -i '16s|#include "ffi.h"|#include "ecl/ffi.h"|g' "${S}"/eda/drivers/sqlite/EDASQLite.ec || die "sed failed"
	sed -i '2s|Version=| |g' "${S}"/share/applications/ecere.desktop || die "sed failed"
	sed -i '10s|Development|Development;|g' "${S}"/share/applications/ecere.desktop || die "sed failed"
}

src_configure() {
	LDFLAGS="-lncurses -ltinfo"
	#econf  --prefix=/usr --sysconfdir=/etc Linux
	make all LINUX_TARGET=linux,TARGET_TYPE=sharedlib,ARCH=x64
}

src_compile() {
	emake || die "emake install failed"
	cd "${S}"/audio/ && make
}

src_install() {
	emake DESTDIR="${D}" install ECERE_AUDIO=n || die "emake install failed"
	#rm -f "${D}"/usr/lib/*.a
	#cp -pfPR "${S}"/compiler/bootstrap/obj/bin.linux.x64/* "${D}"/usr/bin/ || die "copying files failed!"
}
