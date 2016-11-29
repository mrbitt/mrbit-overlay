# Copyright 2011-2013 Gonzalo Exequiel Pedone
# Distributed under the terms of the GNU General Public License v3

EAPI="5"

inherit eutils kde4-base qt4-r2

DESCRIPTION="Webcamoid, the full webcam and multimedia suite."
HOMEPAGE="https://github.com/hipersayanX/Webcamoid"
VER="5.0.0"
SRC_URI="https://github.com/hipersayanX/Webcamoid/archive/v${VER}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="dev-qt/qtgui
         kde-base/kdelibs
         media-video/ffmpeg
         media-plugins/frei0r-plugins"

DEPEND="${RDEPEND}
        sys-devel/bison
        sys-devel/flex"

src_unpack() {
        unpack "v${VER}.tar.gz"

        mv -v "Webcamoid-${VER}" "${P}"
        
}

src_compile() {
    eqmake4  Webcamoid.pro
    emake || die
}

src_install() {
    emake INSTALL_ROOT="${D}" install || die
}
