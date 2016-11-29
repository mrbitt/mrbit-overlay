# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="kde-service multifunction"
HOMEPAGE="thttps://opendesktop.org/content/show.php/kde-services?content=147065"
SRC_URI="http://sourceforge.net/projects/${PN}/files/Source-Code/${PN}-${PV}.tar.bz2"

LICENSE="GPL"
SLOT="0"

inherit eutils

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    sys-apps/dmidecode
    app-text/poppler
    media-video/ffmpeg
    media-video/transcode
    app-text/ghostscript-gpl
    sys-fs/fuseiso
    app-cdr/cdrtools
    sys-apps/diffutils
    dev-util/pkgconfig
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/${PN}-${PV}

#RESTRICT="strip"

src_compile() {
	cd "${S}"
    echo "${S}"
}

src_install() {
    cd "${S}"
    echo "${S}"
    #mkdir "${S}"/image
    #emake DESTDIR="${D}" install || die
    sed "260s|update|##|" -i Makefile || die "sed failed"
    sed "261s|xdg|##|" -i Makefile || die "sed failed"
    sed "262s|xdg|##|" -i Makefile || die "sed failed"
    sed "32s|xdg|##|" -i Makefile || die "sed failed"
    sed "33s|update|##|" -i Makefile || die "sed failed"
    sed "34s|xdg|##|" -i Makefile || die "sed failed"
    sed "35s|xdg|##|" -i Makefile || die "sed failed"
    #sed "2s|update|##|" -i Makefile
    emake "RPM_BUILD_ROOT=${D}" install 
    rm "${D}"/usr/share/applications/System_Tools*kernel*
    #rm "${D}"/usr/share/applications/*package*
   cp "${S}"/ServiceMenus/System-Tools_addtoservicemenu.desktop "${D}"/usr/share/kde4/services/ServiceMenus/System-Tools_addtoservicemenu.desktop
}