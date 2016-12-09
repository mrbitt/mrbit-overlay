# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit  user eutils

DESCRIPTION="QMPlay2 is a video player, it can plays all formats and stream"
HOMEPAGE="http://qt-apps.org/content/show.php/QMPlay2?content=153339"
#SRC_URI="http://downloads.sourceforge.net/project/zaps166/${PN}/${PN}-src-${PV}.tar.xz"
SRC_URI="http://github.com/zaps166/${PN}/releases/download/${PV}/${PN}-src-${PV}.tar.xz"

LICENSE="LGPL"
SLOT="0"
KEYWORDS="amd64 ~i686"
IUSE="-pulseaudio openal kde qt4 +qt5"

DEPEND="qt4? (
		dev-qt/qtcore:4=
		dev-qt/qtgui:4=
		dev-qt/qtscript:4=
	)
	qt5? (
		dev-qt/qtcore:5=
		dev-qt/qtgui:5=
		dev-qt/qtnetwork:5=
		dev-qt/qtscript:5=
		dev-qt/qtwidgets:5=
	) "
RDEPEND="
	media-libs/game-music-emu
	media-libs/libsidplayfp
	dev-qt/qtchooser
	>=media-video/ffmpeg-2.2.0
	media-libs/libass
	media-libs/mesa
	x11-libs/libva
	x11-libs/libXv
	dev-libs/libcdio
	media-libs/portaudio
	>=media-libs/taglib-1.9.1
	media-libs/libcddb
	net-misc/youtube-dl 
	media-video/atomicparsley
	media-video/rtmpdump[abi_x86_32]
	pulseaudio? ( media-sound/pulseaudio )
	openal? ( media-libs/openal )
	"
S=${WORKDIR}/${PN}-src-${PV}

#RESTRICT="strip"  strip on


src_configure(){
        cd "${S}"
      if use openal ; then # activate  libavresample of ffmpeg (openal)
        sed "26s|# DEFINES|DEFINES|" -i src/qmplay2/qmplay2.pro || die "sed failed"
	sed "27s|# LIBS|LIBS|" -i src/qmplay2/qmplay2.pro || die "sed failed"
	sed "28s|# LIBS|LIBS|" -i src/qmplay2/qmplay2.pro || die "sed failed"
      fi
    if ! use pulseaudio ; then
	cd "${S}"
        sed -i "5s|XVideo PulseAudio|XVideo|g" "${S}"/src/modules/modules.pro || die "sed failed"
    fi
    
    if use qt4 ; then
          export QT_SELECT=qt4
	else
	  export QT_SELECT=qt5  
	fi
    lrelease  ${PN}.pro
    qmake ${PN}.pro
    #NOTERM=1 SYSTEM_BUILD=1 ./compile_unix 0
}

src_install() {
	cd ${S}
	
	 dodir /usr
	 mkdir -p app/share/qmplay2/lang
	 mv lang/*.qm app/share/qmplay2/lang
	 
	 if [ -d /usr/share/kde4/apps/solid/actions ]; then
		SOLID_ACTIONS=app/share/kde4/apps/solid/actions
          elif [ -d /usr/share/apps/solid/actions ]; then
		SOLID_ACTIONS=app/share/apps/solid/actions
	 fi
	
	#SedQMPlay2Path=$(echo -n "$PWD" | sed 's/\//\\\//g')

	 mkdir -p app/share/applications
	 cp src/gui/Unix/QMPlay2*.desktop app/share/applications
	
	if use kde ; then
	 if [ ! -z $SOLID_ACTIONS ]; then
		mkdir -p $SOLID_ACTIONS
		cp src/gui/Unix/solid-actions/${PN}-opencda.desktop $SOLID_ACTIONS
	 fi
    fi
    
	 #mkdir -p app/share/icons/hicolor/128x128/apps
	 mkdir -p app/share/icons
	 cp -rf src/gui/Icons/* app/share/icons
	 install -Dm644 "${S}"/src/gui/Windows/"${PN}".ico "${D}/usr/share/pixmaps/${PN}.xpm"
	  	 
	 #rm -f app/share/icons/hicolor/128x128/apps/QMPlay2.png
	 #ln -s ../../../QMPlay2.png app/share/icons/hicolor/128x128/apps
# 	touch app/share/qmplay2/noautoupdates
	 cp ChangeLog app/share/qmplay2
	 mkdir -p app/include/QMPlay2
	 cp src/qmplay2/headers/* app/include/QMPlay2

	echo Build complete!
	
	cp -pPR "${S}"/app/* "${D}"/usr/ || die "copying files failed!"
}
