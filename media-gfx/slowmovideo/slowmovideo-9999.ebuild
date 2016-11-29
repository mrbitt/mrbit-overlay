# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/slowmovideo/slowmovideo-9999.ebuild,v 1.2 2013/03/04 16:12:45 brothermechanic Exp $

EAPI=4

CMAKE_IN_SOURCE_BUILD="1"
EGIT_REPO_URI="https://github.com/slowmoVideo/slowmoVideo.git"

inherit cmake-utils eutils git-2

DESCRIPTION="Create slow-motion videos from your footage"
HOMEPAGE="http://slowmovideo.granjow.net/"
SRC_URI=""
LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="video_cards_nvidia"

DEPEND="virtual/ffmpeg
	media-libs/freeglut
	media-libs/glew
	media-libs/libsdl
	media-libs/opencv
	dev-qt/qtopengl
	dev-qt/qtscript
	dev-qt/qttest
	dev-qt/qtxmlpatterns
	virtual/jpeg"

RDEPEND="${DEPEND}"
PDEPEND="video_cards_nvidia? ( media-gfx/v3d )"

S="${WORKDIR}/${PN}-${PV}"
CMAKE_USE_DIR="${S}"


src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    #kde4-base_src_configure
    mkdir build && cd build
    cmake -DCMAKE_INSTALL_PREFIX=/usr ../src
    #cmake .
    make 
    #eqmake4 ${PN}.pro
    #make clean && make QMAKE=qmake-qt4
    #./configure.sh --prefix=/usr && make QMAKE=qmake-qt4
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

src_install() {
        cd "${S}"/build 
	emake DESTDIR="${D}" install || die "Install failed!"
	#cmake-utils_src_install
	cd "${S}"/src
	newicon slowmoVideo/slowmoUI/res/AppIcon.png "${PN}".png
	make_desktop_entry slowmoUI "slowmoVideo"
	make_desktop_entry slowmoFlowEdit "slowmoFlowEditor"
}