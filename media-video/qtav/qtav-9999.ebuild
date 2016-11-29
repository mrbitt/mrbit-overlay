# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils qmake-utils git-2

DESCRIPTION="media playback based on Qt, FFmpeg and Cuda"
HOMEPAGE="https://github.com/wang-bin/QtAV"
EGIT_REPO_URI="https://github.com/wang-bin/QtAV.git"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="qt4 +qt5"

DEPEND="
	qt5? ( dev-qt/qtdeclarative:5 )
			
	     media-video/ffmpeg
	     >=x11-drivers/nvidia-drivers-340.96
	     x11-libs/libXv
	     media-libs/openal
	     media-libs/portaudio
	     dev-util/desktop-file-utils
	"
RDEPEND=""

S="${WORKDIR}"

src_configure() {
	 if use qt4 ; then
	      qmake INSTALL_PREFIX=/usr
	 else
	     eqmake5 QtAV.pro -r "CONFIG+=no_rpath recheck"
	 fi    
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die
      dodir /usr/bin
   if use qt4 ; then
      ln -s /usr/$(get_libdir)/qt4/bin/player "${D}/usr/bin/qtav-player"
      ln -s /usr/$(get_libdir)/qt4/bin/QMLPlayer "${D}/usr/bin/QMLPlayer"
    else
      ln -s /usr/$(get_libdir)/qt5/bin/player "${D}/usr/bin/qtav-player"
      ln -s /usr/$(get_libdir)/qt5/bin/QMLPlayer "${D}/usr/bin/QMLPlayer"
      #dobin "${D}/usr/$(get_libdir)/qt5/bin/player"
      #dobin "${D}/usr/$(get_libdir)/qt5/bin/QMLPlayer"
   fi 
      install -D src/QtAV.svg "${D}"/usr/share/icons/hicolor/scalable/apps/QtAV.svg
      mv "${D}"/usr/share/applications/{,qtav-}player.desktop
      sed -i '8,9 s/player/qtav-player/' "${D}"/usr/share/applications/qtav-player.desktop
}