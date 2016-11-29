# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# 333235 

EAPI=4

inherit eutils autotools-utils

DESCRIPTION="Basic library functionality for Rodent applications. This includes
two libraries: low level and high level, plus the minimum icon 
emblems and translations."
HOMEPAGE="http://xffm.org/librfm"
SRC_URI="http://sourceforge.net/projects/xffm/files/librfm/${P}.tar.bz2"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE=""

COMMON_DEPEND="
    x11-libs/libX11
	dev-libs/libxml2
	>=dev-libs/glib-2.24
	x11-libs/gtk+:3
	>=x11-libs/cairo-1.8.10
	>=gnome-base/librsvg-2.26
	sys-apps/file
	dev-util/intltool
	virtual/pkgconfig"

RDEPEND="${COMMON_DEPEND}
	x11-libs/libtubo0
	dev-db/libdbh2
"
DEPEND="$RDEPEND"


src_prepare() {
	eautoconf
	elibtoolize
}

src_configure() {
    # before using --with-gtk3 see 
	# https://bugzilla.gnome.org/show_bug.cgi?id=698248
    econf --without-images
}

src_compile() {
	pushd $BUILD_DIR
	emake -C Build DESTDIR=${D} -j2
	popd
}

src_install() {
	pushd $BUILD_DIR
	emake -C Build DESTDIR=${D} install

	dodir /usr/$(get_libdir)/pkgconfig
	insinto /usr/$(get_libdir)/pkgconfig
	doins librfm.pc
	
	dodir /usr/include/rfm
	insinto /usr/include/rfm
	doins ${S}/include/*.h

	dodoc ChangeLog README TODO COPYING NEWS AUTHORS

}



