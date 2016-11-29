# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit multilib unpacker

#MY_PV=${PV/_p/-}
#MY_PN=${PN%%-bin-debian}

DESCRIPTION="a applications dedicated to playback, download and convert videos from YouTube."
HOMEPAGE="http://www.mediahuman.com/"
SRC_URI="amd64? ( http://www.mediahuman.com/files/${PN}.$ARCH.deb )
	x86? ( http://www.mediahuman.com/files/${PN}.$ARCH.deb )"
	
LICENSE="Freeware"
SLOT="0"
KEYWORDS="~amd64 ~i686"
IUSE=""

DEPEND="app-arch/dpkg"
RDEPEND="
	dev-qt/qtcore:4
	>=media-video/ffmpeg-1
	"

S=${WORKDIR}

#QA_PREBUILT="usr/lib*/${MY_PN}/*"

RESTRICT="strip"

src_install() {
	#sed -i '9s|Network|Application;Network|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
        sed -i '4s|Saves aoudio track from YouTube|Pulls audio tracks from YouTube videos|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
}
