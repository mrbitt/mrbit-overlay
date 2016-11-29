# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Is the clone from WinHTTrack tool. GUI is based on Qt4 libriaries"
HOMEPAGE="http://qt-apps.org/content/show.php/CuteReport?content=156233"
SRC_URI="http://sourceforge.net/projects/qreport/files/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

inherit qt4-r2 

KEYWORDS="amd64 ~mips x86"

RDEPEND="dev-qt/qtgui:4"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    media-gfx/imagemagick
    >=kde-base/kdelibs-4.4:4[aqua=]"

   
S="${WORKDIR}/alfox-report-02622eac8369"


src_prepare() {
	 cd "${S}"
}


src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
   # if use debug; then
#		eqmake4 -config debug 
#	else
#		eqmake4 -config release
#	fi
#	eqmake4|| die "emake failed"
    qmake
    make
    #sed -i "9s|httraqt.xpm|httraqt|g" "${S}"/desktop/httraqt.desktop || die "sed failed"
    #kde4-base_src_configure
    #cmake -DQT_QMAKE_EXECUTABLE=qmake-qt4 -DCMAKE_INSTALL_PREFIX=/usr ..
}

src_install() {
    cd "${S}"
    dodir /usr/bin
    dodir /usr/lib
    dodir /usr/share/cutereport
    cp -R "${S}"/examples "${D}"/usr/share/cutereport
    cp -R "${S}"/images_all "${D}"/usr/share/cutereport
    cp "${S}"/build/cutereport_gui "${D}"/usr/bin/
    cp -R "${S}"/build/{cutereport,designer} "${D}"/usr/lib/
    cp "${S}"/build/libCu* "${D}"/usr/lib/
    cp "${S}"/build/libPr* "${D}"/usr/lib/
    
    make "INSTALL_ROOT_PATH=${D}" install
    sh /build/cutereport.sh
    #einstall
    #emake BUILD="${S}"/build INSTALL_ROOT_PATH="${D}" install || die "emake install failed"
        #echo "${WORKDIR}"
    #chmod 0755 "${WORKDIR}"/${P}_build/httraqt || die "chmod failed"
    #kde4-base_src_install
    #emake BUILD="${S}"/build  DESTDIR="${D}" install
    #dodoc README CHANGES
}
