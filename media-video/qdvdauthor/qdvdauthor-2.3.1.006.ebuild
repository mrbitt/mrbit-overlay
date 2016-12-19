#Copyright (C) 2014 Angelo e Calogero Scarnà
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5

inherit eutils cmake-utils versionator

MY_PV=$(replace_version_separator 3 '-')
MY_P=${PN}-${MY_PV}
MY_PP=$(version_format_string 'qdvd-$1.$2.$3') 
MY_PS=$(version_format_string '${PN}-$1.$2.$3') 

RESTRICT="mirror"

DESCRIPTION="Software per il calcolo del codice fiscale"
HOMEPAGE="http://www.codelinsoft.it"
SRC_URI="https://sourceforge.net/projects/qdvd/files/${MY_PP}-qt5/${MY_P}.tar.gz 
         http://ffmpeg.org/releases/ffmpeg-0.6.3.tar.bz2 "

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+qt5 dvdr"
DEPEND=" 
			 dev-qt/qtcore:5
			 dev-qt/qtgui:5
			 dev-qt/qtmultimedia:5
			 dev-qt/qtgraphicaleffects:5
			 dev-qt/qtnetwork:5
			 dev-qt/qtwidgets:5
			 dev-qt/qtxml:5
			 media-video/vlc
			 media-libs/xine-lib
			 virtual/ffmpeg"

RDEPEND="${DEPEND}
          media-video/transcode
          app-cdr/dvdisaster
          media-video/dv2sub
          media-sound/toolame
          media-video/dvd-slideshow
          media-video/videotrans
          app-cdr/cdrtools"
          #app-cdr/cdrkit
         #dvdr? ( media-video/dvdrtools )"
          
S=${WORKDIR}/${MY_PS}

src_prepare() {
       
       cp -rup  ${WORKDIR}/ffmpeg-0.6.3 "${S}"/qdvdauthor/qrender/ || die "failed copy"
       #sed -i "359s|#add_subdirectory(qrender)|add_subdirectory(qrender)|g" CMakeLists.txt || die "sed failed"
       sed -i "10s|X-Red-Hat-Base;||g" "${S}"/${PN}.desktop || die "sed failed"
       sed -i "10s|Application;||g" "${S}"/${PN}.desktop || die "sed failed"
}

src_configure() {
	     mycmakeargs=(
		$(cmake-utils_use_with qt5)
		-DCMAKE_BUILD_TYPE=Release
		-DCMAKE_INSTALL_PREFIX=/usr -DWANT_QT4=ON  )
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}
