#Copyright (C) 2014 Angelo e Calogero Scarnà
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5

inherit eutils cmake-utils

RESTRICT="mirror"

DESCRIPTION="Software per il calcolo del codice fiscale"
HOMEPAGE="http://www.codelinsoft.it"
SRC_URI="http://www.codelinsoft.it/sito/download/categoria-linux/CodiceFiscale/${PN}-3-0targz.raw -> codicefiscale-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="qt4 +qt5"
DEPEND=" 
		qt4? ( dev-qt/qtcore:4
			 dev-qt/qtgui:4
			 dev-qt/qtxmlpatterns
			 dev-qt/qt3support:4 )
		
		qt5? ( dev-qt/qtcore:5
			 dev-qt/qtgui:5
			 dev-qt/qtmultimedia:5
			 dev-qt/qtgraphicaleffects:5
			 dev-qt/qttranslations:5
			 dev-qt/qtsvg:5
			 dev-qt/qtdeclarative:5
			 ev-qt/qtwebsockets:5
			 dev-qt/linguist:5
			 dev-qt/qtxmlpatterns:5
			 dev-qt/qtnetwork:5
			 dev-qt/qtx11extras:5
			 dev-qt/qtxml:5 )
"
RDEPEND="${DEPEND}"

src_unpack() {
    unpack ${A}
}

src_prepare() {
	   sed -i cod_fisc/desktop/${PN}.desktop -e 's:Application;Office:Office;:' || die
	   sed -i -e '17d' cod_fisc/desktop/${PN}.desktop  || die
}

src_configure() {
        if use qt4 ; then
           mycmakeargs=(
		$(cmake-utils_use_with qt4)
		-DCMAKE_INSTALL_PREFIX=/opt -DWANT_QT4=ON  )
	else
	    mycmakeargs=(
		$(cmake-utils_use_with qt5)
		-DCMAKE_INSTALL_PREFIX=/opt -DWANT_QT4=ON  )
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
        cp -rv  "cod_fisc/codicefiscale.db" "${D}/opt/codicefiscale/"
}