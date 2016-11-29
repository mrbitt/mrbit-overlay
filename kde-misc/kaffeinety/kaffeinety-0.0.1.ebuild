# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Is a application to temporarity prevents dim screen action of power management and screensaver for KDE environment"
HOMEPAGE="http://kde-apps.org/content/show.php?content=159860"
SRC_URI="http://kde-apps.org/CONTENT/content-files/159860-KaffeineTY.zip"

LICENSE="GPL"
SLOT="0"

inherit kde4-base

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/KaffeineTY

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"/build
    #sed -i "9s|httraqt.xpm|httraqt|g" "${S}"/desktop/httraqt.desktop || die "sed failed"
    kde4-base_src_configure
    cmake -DQT_QMAKE_EXECUTABLE=qmake-qt4 -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr ..
}

src_install() {
    cd "${S}"/build 
    echo "${WORKDIR}"
   # chmod 0755 "${WORKDIR}"/httraqt-1.1.0_build/httraqt || die "chmod failed"
    kde4-base_src_install
    #emake BUILD="${S}"/build  DESTDIR="${D}" install
    #dodoc README CHANGES
}
