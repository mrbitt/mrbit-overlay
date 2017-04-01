# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools

DESCRIPTION="Simple image editor"
HOMEPAGE="www.linux-apps.com/p/1129305/"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+gegl03"

DEPEND="x11-libs/gtk+:2[introspection]
	    >=media-libs/gegl-0.2
	   gegl03? ( >=media-libs/gegl-0.3 )
	    dev-util/intltool
	    media-libs/babl"
RDEPEND="${DEPEND}"
DEPEND+="
	virtual/pkgconfig"

G2CONF+="
    --disable-maintainer-mode
	--docdir=/usr/share/doc/${PN}
	--htmldir=/usr/share/doc/${PN}
	--disable-werror
	--disable-static"

DOCS=( AUTHORS ChangeLog NEWS README )

src_configure() {
     	if use gegl03 ; then
     	sed -i "s|gegl-chant.h|gegl-op.h|g" gegl/insta-1977/dibuja-insta-1977.c || die "sed failed"
     	sed -i "s|gegl-chant.h|gegl-op.h|g" gegl/insta-brannan/dibuja-insta-brannan.c || die "sed failed"
     	sed -i "s|gegl-chant.h|gegl-op.h|g" gegl/red-eye-removal/dibuja-red-eye-removal.c || die "sed failed"
	      local myconf=(
	         --with-gegl-0.3  )
	    fi
	   
	econf ${myconf[@]} 
}
