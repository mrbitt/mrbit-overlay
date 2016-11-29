# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

inherit subversion

DESCRIPTION="Ultimate++ framework"
HOMEPAGE="http://www.ultimatepp.org/"
SRC_URI=""

ESVN_REPO_URI="http://upp-mirror.googlecode.com/svn/trunk/"
ESVN_PROJECT="upp"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
RDEPEND="sys-devel/gcc
	 dev-libs/glib
	 x11-libs/gtk+
	 media-libs/freetype
	 x11-libs/cairo
	 x11-libs/libXinerama
	 dev-libs/atk
	 x11-libs/pango"

DEPEND="${RDEPEND}"

S=${WORKDIR}/upp

src_compile() {
	mkdir -p ~/.upp/theide
	echo "UPP = \"${S}/uppsrc\"" >> ~/.upp/theide/uppsrc.var
	echo "BUILDER = \"GCC\";" >> ~/.upp/theide/GCC.bm
	echo "RELEASE_OPTIONS = \"${CXXFLAGS} -ffunction-sections -fdata-sections\"" >> ~/.upp/theide/GCC.bm
	echo "RELEASE_LINK = \"${LDFLAGS} --gc-sections\"" >> ~/.upp/theide/GCC.bm
	echo 'INCLUDE =	"/usr/include/freetype2;/usr/include/gtk-2.0;/usr/include/glib-2.0;/usr/lib/glib-2.0/include;/usr/lib/gtk-2.0/include;/usr/include/cairo;/usr/include/pango-1.0;/usr/include/atk-1.0;/usr/X11R6/include;/usr/X11R6/include/freetype2;/usr/X11R6/include/gtk-2.0;/usr/X11R6/include/glib-2.0;/usr/X11R6/lib/glib-2.0/include;/usr/X11R6/lib/gtk-2.0/include;/usr/X11R6/include/cairo;/usr/X11R6/include/pango-1.0;/usr/X11R6/include/atk-1.0";' >> ~/.upp/theide/GCC.bm
	echo 'LIB = "/usr/X11R6/lib;/usr/lib";' >> ~/.upp/theide/GCC.bm
	theide uppsrc ide GCC -lrsxM ">GUI" ${S}/uppsrc
	cd ${S}/uppsrc
	emake || die "make failed"
}

src_install () {
	einfo "Installing TheIDE (safe to ignore following QA warnings)..."
	mv ${S}/uppsrc/ide.out ${S}/theide
	dobin theide

	mkdir -p ${D}/usr/share/upp
	cp ${S}/GCC.bm ${D}/usr/share/upp
	cp -r ${S}/bazaar ${D}/usr/share/upp
	cp -r ${S}/examples ${D}/usr/share/upp
	cp -r ${S}/reference ${D}/usr/share/upp
	cp -r ${S}/tutorial ${D}/usr/share/upp
	cp -r ${S}/uppsrc ${D}/usr/share/upp
}
