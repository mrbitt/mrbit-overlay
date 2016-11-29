# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=1

inherit eutils toolchain-funcs

MY_P=${PN}-x11-src-${PV}
DESCRIPTION="Ultimate++ is a C++ cross-platform rapid application development framework"
HOMEPAGE="http://www.ultimatepp.org/"
#SRC_URI="http://sourceforge.net/projects/${PN}/files/${PN}/${PV}/${MY_P}.tar.gz"
SRC_URI="http://sourceforge.net/projects/upp/files/${PN}/2015.2/${MY_P}.tar.gz"
#SRC_URI="http://upp-mirror.googlecode.com/files/upp-x11-src-${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-libs/atk
	dev-libs/expat
	dev-libs/glib
	media-libs/freetype
	x11-libs/cairo
	x11-libs/gtk+:2
	x11-libs/libnotify
	x11-libs/libXinerama
	x11-libs/pango"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${MY_P}"

src_compile () {
        cd ${S}
        
	if which pkg-config
then
	sed -e "s@-I((INCLUDES))@`pkg-config --cflags-only-I gtk+-2.0`@g" uppsrc/Makefile.in >uppsrc/Makefile
	sed -e "s@((INCLUDES))@`pkg-config --cflags-only-I gtk+-2.0|sed -e s/-I//g -e \"s/ /;/g\"`@g" GCC.bm.in >GCC.bm
else
	sed -e "s@((INCLUDES))@@g" uppsrc/Makefile.in >uppsrc/Makefile
	sed -e "s@((INCLUDES))@@g" GCC.bm.in >GCC.bm
fi

if [ ! -f /usr/lib/libdl.so ]
then
	cd uppsrc
	sed -e s/-ldl//g Makefile >Makefile2
	rm Makefile
	mv Makefile2 Makefile
	cd ..
fi

if which gmake
then
	gmake -C uppsrc
else
	make -C uppsrc
fi

cp uppsrc/ide.out ./theide	
}

src_install () {
	cd ${S}
	newbin uppsrc/ide.out theide || die
	rm -rf uppsrc/_out || die
	insinto /usr/share/${PN}
	doins -r GCC.bm bazaar examples reference tutorial uppsrc || die
	make_desktop_entry theide TheIDE /usr/share/${PN}/uppsrc/ide/theide-48.png
}

