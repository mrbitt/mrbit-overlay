# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#### for isomd5sum --> layman -a sabayon  ##

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
    app-cdr/isomd5sum 
    app-text/poppler
    media-video/ffmpeg
    media-video/transcode
    app-text/ghostscript-gpl
    dev-util/android-tools
    net-misc/youtube-dl
    media-sound/sox
    sys-fs/fuseiso
    media-fonts/liberation-fonts
    media-video/mkvtoolnix
    net-misc/wget
    x11-misc/shared-mime-info
    x11-misc/xdg-utils
    sys-process/procps
    app-arch/unar
    sys-apps/util-linux
    app-misc/mc
    sys-apps/gawk
    app-text/pdftk
    media-video/dvdauthor
    net-fs/samba
    media-video/vlc
    sys-process/psmisc
    app-crypt/gnupg
    app-text/recode
    app-accessibility/festival
    media-gfx/imagemagick
    sys-apps/findutils
    sys-process/htop
    media-libs/exiftool
    net-fs/cifs-utils
    www-client/lynx
    app-cdr/cdrtools
    sys-fs/sshfs-fuse
    dev-haskell/iproute
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
    #sed "305s|update|##|" -i Makefile || die "sed failed"
    #sed "306s|xdg|##|" -i Makefile || die "sed failed"
    #sed "307s|xdg|##|" -i Makefile || die "sed failed"
    #sed "38s|xdg|##|" -i Makefile || die "sed failed"
    #sed "39s|update|##|" -i Makefile || die "sed failed"
    #sed "40s|xdg|##|" -i Makefile || die "sed failed"
    #sed "41s|xdg|##|" -i Makefile || die "sed failed"
      #sed "2s|update|##|" -i Makefile
   sed -e '/mkdir\ -p \$\(PREFIXservicetypes5\)/ s/^#*/#/' -i Makefile
   sed -e '/servicetypes\/\*/ s/^#*/#/' -i Makefile
  
    sed -e '/xdg-mime/ s/system/user/' -i Makefile
    sed -e '/xdg-mime install/ s/^#*/#/' -i Makefile
    sed -e '/update-mime-database/ s/^#*/#/' -i Makefile
    sed -e '/xdg-icon-resource/ s/^#*/#/' -i Makefile
    sed -e '/xdg-desktop-menu/ s/^#*/#/' -i Makefile 
    
    emake "RPM_BUILD_ROOT=${D}" install 
    rm "${D}"/usr/share/applications/System_Tools*kernel*
    #rm "${D}"/usr/share/applications/*package*
    #cp "${S}"/ServiceMenus/System-Tools_addtoservicemenu.desktop "${D}"/usr/share/kde4/services/ServiceMenus/System-Tools_addtoservicemenu.desktop
}