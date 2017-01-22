#Copyright (C) 2014 Angelo e Calogero Scarnà
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5

EGIT_REPO_URI="https://github.com/DexterMagnific/${PN}.git"
inherit git-2 eutils qmake-utils

RESTRICT="mirror"

DESCRIPTION="Is a themeable SVG style for Qt4 and Qt 5 applications."
HOMEPAGE="http://www.codelinsoft.it"
SRC_URI=""

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+doc qt4 +qt5"
DEPEND=" 
		qt4? ( dev-qt/qtcore:4
			 dev-qt/qtgui:4
			 dev-qt/qtsvg:4
			 dev-qt/qtxmlpatterns
			 dev-qt/qt3support:4 )
		
		qt5? ( dev-qt/qtcore:5
			 dev-qt/qtgui:5
			 dev-qt/qtgraphicaleffects:5
			 dev-qt/qtsvg:5
			 dev-qt/qtwidgets:5
			 dev-qt/linguist:5
			 dev-qt/qtx11extras:5 )
"
RDEPEND="${DEPEND}"

src_configure() {
		if use qt4 ; then
			eqmake4
	    else
			eqmake5
	    fi
}

src_compile() {
	if use qt4 ; then
		 eqmake4 ${PN}.pro
	     emake || die
	else
	    eqmake5 ${PN}.pro
	    emake || die
	fi
	   lrelease ${PN}.pro
}

src_install() {
    #emake DESTDIR="${D}" install || die "Install failed!"
    emake INSTALL_ROOT="${D}" install || die
    cp -rf TODO doc/ || die
    if use doc ; then
        einstalldocs 
        dodoc COPYING README.md TODO || die 
        dodoc doc/*
    fi    
}
