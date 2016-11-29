# Copyright 2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

WX_GTK_VER="2.9"
inherit wxwidgets

DESCRIPTION="FreeFileSync is a folder comparison and synchronization tool"
HOMEPAGE="http://sf.net/projects/freefilesync"
#SRC_URI="http://cznic.dl.sourceforge.net/project/${PN}/${PN}/${PV}/FreeFileSync_${PV}_Source.zip"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/FreeFileSync/${PV}/FreeFileSync_${PV}_Source.zip"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip >=sys-devel/gcc-4.7 x11-libs/wxGTK:2.9[X] >=dev-libs/zenxml-2.1"
RDEPEND=">=x11-libs/wxGTK-2.9.5[X]
	 >=net-libs/webkit-gtk-2.4.8
	  dev-libs/boost"

S=${WORKDIR}

src_compile(){
	cd FreeFileSync/Source
	sed -i "s_-I../.._-I.. -I../.._" Makefile || die "sed failed"
	emake BUILD=Launchpad || die "emake failed for FreeFileSync"
	cd RealtimeSync
	sed -i "s_-I../../.._-I../.. -I../../.._" Makefile || die "sed failed"
	emake BUILD=Launchpad || die "emake failed for RealtimeSync"
}

src_install(){
	cd FreeFileSync/Source
	emake DESTDIR="${D}" install || die "Install failed for FreeFileSync"
	cd RealtimeSync
	emake DESTDIR="${D}" install || die "Install failed for RealtimeSync"
	
	newicon FreeFileSync.png FreeFileSync.png

    make_desktop_entry "FreeFileSync" "Synchronize files and folders" "FreeFileSync" "System;Utility"
    newicon RealtimeSync.png RealtimeSync.png
    make_desktop_entry "RealtimeSync" "Synchronize files and folders in realtime" "RealtimeSync" "System;Utility"
    #make_desktop_entry /usr/bin/FreeFileSync FreeFileSync /usr/share/FreeFileSync/Help/img/ffsicon.png Utility;
}
