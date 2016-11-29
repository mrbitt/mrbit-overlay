# Copyright 2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

WX_GTK_VER="3.0"
inherit wxwidgets

DESCRIPTION="FreeFileSync is a folder comparison and synchronization tool"
HOMEPAGE="http://sf.net/projects/freefilesync"
SRC_URI="http://kent.dl.sourceforge.net/project/${PN}/FreeFileSync/archive/FreeFileSync_${PV}_Source.zip"
LICENSE="GPL-3"

SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip >=sys-devel/gcc-4.7 x11-libs/wxGTK:2.9[X] dev-cpp/zenxml"
RDEPEND=">=x11-libs/wxGTK-2.9.5[X] dev-libs/boost"

S=${WORKDIR}

src_prepare() {
	sed -i '10s|"zen/warn_static.h"|"zen/warn_static.h" -include "wx/bitmap_button.h"|g' "${S}"/FreeFileSync/Source/Makefile || die "sed failed"
	#epatch "${FILESDIR}"/wxGTK-2.9.5-collision.patch || die "patch failed"
}

src_compile(){
	cd FreeFileSync/Source
	 sed -i "s_-I../.._-I.. -I../.._" Makefile
	 #sed -i 's/wx-config --/wx-config-3.0 --/' Makefile
	 sed -i 's/zenXml/zenxml/' Makefile
         #sed -i 's/CXXFLAGS[ \t]*=/CXXFLAGS = -Wno-unused-local-typedefs -Wno-deprecated-declarations -Wno-literal-suffix /' Makefile
        emake BUILD=Launchpad || die "emake failed for FreeFileSync"
	
	cd RealtimeSync
	  sed -i "s_-I../.._-I.. -I../.._" Makefile
	  sed -i 's/zenXml/zenxml/' Makefile
	  #sed -i 's/CXXFLAGS[ \t]*=/CXXFLAGS = -Wno-unused-local-typedefs -Wno-deprecated-declarations -Wno-literal-suffix /' Makefile
	emake BUILD=Launchpad || die "emake failed for RealtimeSync"
}

src_install(){
	cd FreeFileSync/Source
	emake DESTDIR="${D}" install || die "Install failed for FreeFileSync"
	cd RealtimeSync
	emake DESTDIR="${D}" install || die "Install failed for RealtimeSync"
	
	make_desktop_entry /usr/bin/FreeFileSync FreeFileSync /usr/share/FreeFileSync/Help/img/ffsicon.png Utility;
}
