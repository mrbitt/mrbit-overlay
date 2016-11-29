# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib unpacker

#MY_PV=${PV/_p/-}
#MY_PN=${PN%%-bin-debian}

DESCRIPTION="3D CAD-CAM application that features an integrated 3D OpenGL viewer."
HOMEPAGE="http://opendesktop.org/content/show.php/gCAD3D?content=88766"
SRC_URI="amd64? ( http://www.gcad3d.org/download/${PN}-${PV}-bin-amd64.deb )
	x86? ( http://www.gcad3d.org/download/${PN}-${PV}-bin-i386.deb )"
	
LICENSE="GPL-v3"
SLOT="0"
KEYWORDS="~amd64 ~i686"
IUSE=""

DEPEND="app-arch/dpkg"
RDEPEND="
	>=dev-libs/glib-2
	x11-libs/gtk+:3
	dev-util/pkgconfig
	gnome-extra/zenity
	media-libs/glu
	media-libs/libjpeg-turbo"

S=${WORKDIR}

#QA_PREBUILT="usr/lib*/${MY_PN}/*"

#RESTRICT="strip"

src_install() {
	#sed -i '9s|Network|Application;Network|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
        #sed -i '4s|Saves aoudio track from YouTube|Pulls audio tracks from YouTube videos|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
	dodir /usr/share/applications || die "mkdir failed!"
	#ln -s "${D}usr/lib/gCAD3D/binLinux64/xa_gui_gtk3.so" "${D}usr/lib/gCAD3D/binLinux64/xa_gui.so" || die 
	cp "${S}/usr/share/gcad3d/${PN}.desktop" "${D}/usr/share/applications/${PN}.desktop"
}
