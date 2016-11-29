# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit qmake-utils gnome2-utils fdo-mime

DESCRIPTION=" is a cross-platform patternmaking program which allows designers to create and model patterns of clothing"
HOMEPAGE="http://opendesktop.org/content/show.php/Valentina?content=169329"
SRC_URI="https://bitbucket.org/dismine/valentina/get/default.zip -> ${P}.zip"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="+man linguas_cs linguas_de linguas_fr linguas_he linguas_id linguas_it linguas_nl linguas_ru linguas_uk"

CDEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/qtmultimedia:5
	dev-qt/qtdbus:5
	dev-qt/qtxml:5
	dev-qt/qtsvg:5
	dev-qt/linguist:5
	dev-qt/qtxmlpatterns:5
	dev-qt/qtprintsupport:5
	dev-qt/qtnetwork:5
	app-text/poppler"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	dev-util/ccache"
	
S=${WORKDIR}/dismine-${PN}-3a1a7455ecf2

src_compile() {
	cd ${S}
	eqmake5 LRELEASE=lrelease PREFIX=/usr PREFIX_LIB=/usr/lib CONFIG+=no_ccache Valentina.pro -r
	cd src && make
}

src_install() {
        cd src
	emake install INSTALL_ROOT="${D}"
	dodoc ${S}/LICENSE_GPL.txt ${S}/ChangeLog.txt ${S}/README.txt
    if use man; then
       doman ${S}/dist/debian/${PN}.1 || die
       doman ${S}/dist/debian/tape.1 || die
    fi
        cp ${S}/dist/debian/valentina.sharedmimeinfo ${S}/dist/debian/${PN}.xml
        insinto /usr/share/mime/packages
        doins ${S}/dist/debian/${PN}.xml || die   
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
