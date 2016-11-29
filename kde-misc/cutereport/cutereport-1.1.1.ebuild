# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib unpacker

#MY_PV=${PV/_p/-}
#MY_PN=${PN%%-bin-debian}

DESCRIPTION="CuteReport is an easy, powerful and extendable report solution based on Qt4 framework"
HOMEPAGE="https://cute-report.com/"
SRC_URI="http://sourceforge.net/projects/qreport/files/Linux/${PN}_${PV}-gpl_%28ubuntu14.04_qt4%29_amd64.deb"
	
LICENSE="GPL-v3"
SLOT="0"
KEYWORDS="~amd64 ~i686"
IUSE=""

RDEPEND="dev-qt/qtgui:4"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    media-gfx/imagemagick
    kde-misc/zint
    >=kde-base/kdelibs-4.4:4"

S=${WORKDIR}

#QA_PREBUILT="usr/lib*/${MY_PN}/*"

#RESTRICT="strip"

src_install() {
	#sed -i '9s|Network|Application;Network|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
        #sed -i '4s|Saves aoudio track from YouTube|Pulls audio tracks from YouTube videos|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
	#dodir /usr/share/applications || die "mkdir failed!"
	#ln -s "${D}usr/lib/gCAD3D/binLinux64/xa_gui_gtk3.so" "${D}usr/lib/gCAD3D/binLinux64/xa_gui.so"
	#cp "${S}/usr/share/gcad3d/${PN}.desktop" "${D}/usr/share/applications/${PN}.desktop"
}
