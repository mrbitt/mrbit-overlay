#Copyright (C) 2014 Angelo e Calogero Scarnà
# Distributed under the terms of the GNU General Public License v3
# $Header: $

EAPI=5

RESTRICT="mirror"


DESCRIPTION="Software per il calcolo del codice fiscale"
HOMEPAGE="http://www.codelinsoft.it"
SRC_URI="http://www.codelinsoft.it/sito/download/categoria-linux/CodiceFiscale/codice-fiscale-source.raw -> codicefiscale-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+qt4 qt5"
DEPEND=" 
		qt4? ( dev-qt/qtcore:4
			 dev-qt/qtgui:4
			 dev-qt/qtxmlpatterns
			 dev-qt/qt3support:4 )
		
		qt5? ( dev-qt/qtcore:5
			 dev-qt/qtgui:5
			 dev-qt/qtnetwork:5
			 dev-qt/qtxml:5 )
"
RDEPEND="${DEPEND}"

src_unpack() {
    unpack ${A}
}

src_prepare() {
     if use qt4; then
	qmake
     fi
     
     if use qt5; then
        qmake 
     fi
}

src_compile(){
	make -j5
}

src_install(){
	dodir /opt/codicefiscale
	dodir /usr/share/applications
	cd ${WORKDIR}
	cp -r "${P}/cod_fisc/codicefiscale" "${D}opt/codicefiscale" || die
	dosym /opt/codicefiscale/codicefiscale  /usr/bin/codicefiscale
	cp -r "${P}/update" "${D}opt/codicefiscale" || die
	insinto /opt/codicefiscale
	newins "${P}/cod_fisc/images/codicefisc.png"  codicefisc.png
	insinto /usr/share/applications
	newins "${P}/cod_fisc/desktop/codicefiscale.desktop" codicefiscale.dektop
        chmod 777 "${D}/opt/codicefiscale"
}
