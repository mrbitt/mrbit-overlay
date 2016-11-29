# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

DESCRIPTION="Qt application that allows you to sync folders..."
HOMEPAGE="http://synkron.sourceforge.net/index.shtml"
SRC_URI="http://downloads.sourceforge.net/project/synkron/synkron/${PV}/${P}-src.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE=""

inherit qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND="dev-qt/qtgui:4"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    media-gfx/imagemagick
    >=kde-base/kdelibs-4.4:4[aqua=]"

   
S="${WORKDIR}/${P}-src"


src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    lrelease "${PN}".pro
    if use debug; then
		eqmake4 -config debug
	else
		eqmake4 -config release
	fi
	eqmake4|| die "emake faileddispatch-conf."
#    exec squirrelsh build.nut
#    qmake -config release
 #   make
    #sed -i "9s|httraqt.xpm|httraqt|g" "${S}"/desktop/httraqt.desktop || die "sed failed"
    #kde4-base_src_configure
    #cmake -DQT_QMAKE_EXECUTABLE=qmake-qt4 -DCMAKE_INSTALL_PREFIX=/usr ..
}

src_install() {
    cd "${S}"
    dodir /usr/share/applications/
    dodir /usr/share/pixmaps/
    dodir /usr/bin/
    cp "${FILESDIR}"/synkron.desktop "${D}"usr/share/applications/synkron.desktop
    cp "${S}"/images/Synkron48.ico "${D}"usr/share/pixmaps/Synkron48.ico || die
    cp "${S}"/synkron "${D}"/usr/bin/synkron
    #einstall
    #emake DESTDIR="${D}" install
    #emake INSTALL_ROOT_PATH="${D}" DESTDIR="${D}" install || die "emake install failed"
        #echo "${WORKDIR}"
    #chmod 0755 "${WORKDIR}"/${P}_build/httraqt || die "chmod failed"
    #kde4-base_src_install
    #emake BUILD="${S}"/build  DESTDIR="${D}" install
    #dodoc README CHANGES
}