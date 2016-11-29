# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit 

DESCRIPTION="Yad Trash Management"
HOMEPAGE="http://kde-look.org/content/show.php/Yad+Trash+Management?content=174297"
SRC_URI="http://kde-look.org/CONTENT/content-files/174297-${PN}.zip"

LICENSE="GPL"
SLOT="0"
IUSE="debug"

KEYWORDS="amd64 x86"

RDEPEND="media-fonts/DroidLogo
	 x11-misc/yad
	 app-misc/trash-cli"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"


src_configure(){
       cd "${S}"
}

src_install() {
    cd "${S}"
    sed -i '11s|System|System;|g' *.desktop || die "sed failed"
    sed -i -e '8d' *.desktop || die "sed failed"
    dodir /usr/bin
    dodir /usr/share/{applications,icons}
    cp *.desktop "${D}/usr/share/applications" -rf
    cp *.svg *.png "${D}/usr/share/icons" -rf
    chmod +x "${PN}"
    cp "${PN}" "${D}/usr/bin" -rf
}
