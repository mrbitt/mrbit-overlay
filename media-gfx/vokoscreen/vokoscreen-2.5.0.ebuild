# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION=" GUI ffmpeg based on Qt4 libriaries."
HOMEPAGE="http://www.kohaupt-online.de/"
SRC_URI="https://github.com/vkohaupt/vokoscreen/archive/${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils qt4-r2 qmake-utils

KEYWORDS="amd64 ~mips x86"
IUSE="-pulseaudio alsa"

RDEPEND="kde-frameworks/oxygen-icons"
DEPEND="${RDEPEND}
    dev-qt/qtcore:5
    dev-qt/qtwidgets:5
    dev-qt/qtx11extras:5
    media-video/ffmpeg
    media-sound/lame
    sys-process/lsof
    media-video/mkvtoolnix
    media-libs/opencv
    pulseaudio? ( media-sound/pulseaudio )
    "
    
S=${WORKDIR}/${PN}-${PV}
#RESTRICT="strip"

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    #kde4-base_src_configure
    #cmake .
    #make 
    sed -i "s|lrelease-qt5|lrelease|g" "${S}"/${PN}.pro || die "sed failed"
    export QT_SELECT := qt5 
    lrelease ${PN}.pro
    eqmake5  ${PN}.pro
    #make clean && make LRELEASE=lrelease QMAKE=qmake-qt5 PREFIX=/usr
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    #emake DESTDIR="${D}" install || die "Install failed!"
    #kde4-base_src_install
    qt4-r2_src_install
    #dodir /usr/local/bin
    #cp "${S}"/build/hotshots "${D}"/usr/local/bin
}
