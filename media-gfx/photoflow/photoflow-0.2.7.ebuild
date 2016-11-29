# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="A fully non-destructive photo retouching program providing a complete layer-based workflow including RAW image development"
HOMEPAGE="https://github.com/aferrero2707/PhotoFlow"
SRC_URI="https://github.com/aferrero2707/PhotoFlow/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils

KEYWORDS="amd64 ~mips x86"

RDEPEND="dev-util/cmake
	 dev-cpp/gtkmm
	 media-libs/lensfun"
DEPEND="${RDEPEND}
    sci-libs/fftw
    >=media-libs/vips-8.3.3
    media-libs/tiff
    media-gfx/exiv2
    dev-libs/libxml2
    media-libs/libjpeg-turbo
    media-libs/gexiv2"
    
S=${WORKDIR}/PhotoFlow-${PV}
RESTRICT="strip"

src_configure(){
    cd "${S}"
    cmake -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr -DINSTALL_PREFIX=/usr ./
    #make 
}

src_install() {
        cd "${S}"
         echo "${WORKDIR}"
         #make install INSTALL_ROOT="${D}"/usr
         emake DESTDIR="${D}" install || die "Install failed!"
         make_desktop_entry ${PN} "PhotoFlow" "/usr/share/${PN}/icons/preview_active.svg" "Graphics;"
         rm -R "${D}"/usr/share/applications/${PN}.desktop || die "not exist file"
}
