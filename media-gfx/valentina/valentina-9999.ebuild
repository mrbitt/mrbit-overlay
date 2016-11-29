# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit mercurial qmake-utils gnome2-utils fdo-mime

DESCRIPTION="Cloth patternmaking software"
HOMEPAGE="http://valentinaproject.bitbucket.org/"
SRC_URI=""
EHG_REPO_URI="https://bitbucket.org/dismine/valentina"
EHG_REVISION="develop"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="+man linguas_cs linguas_de linguas_fr linguas_he linguas_id linguas_it linguas_nl linguas_ru linguas_uk"

CDEPEND="
	app-text/poppler
	dev-qt/qtcore:5
	dev-qt/qtprintsupport:5
	dev-qt/qtsvg:5
	dev-qt/qtwidgets:5
	dev-qt/qtxml:5
	dev-qt/qtxmlpatterns:5"
RDEPEND="${CDEPEND}"
DEPEND="${CDEPEND}
	dev-util/ccache"

S=${WORKDIR}/${P}

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