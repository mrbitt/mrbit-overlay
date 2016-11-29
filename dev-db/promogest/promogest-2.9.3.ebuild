# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django/django-0.95.ebuild,v 1.2 2006/08/13 15:40:12 lucass Exp $

EAPI="4"
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils unpacker

DESCRIPTION="Italian ERP Software"
HOMEPAGE="http://promogest.promotux.it"
SRC_URI="http://www.promogest.me/templates/promoGest/ex_ftp/${PN}_${PV}-0_all.deb"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="sqlite postgres mysql examples test"

DEPEND="app-arch/dpkg
	>=dev-python/setuptools-0.6_rc1
	test? ( || (
		( >=dev-python/pysqlite-2.0.3 <dev-lang/python-2.5 )
		>=dev-lang/python-2.5 ) )"

RDEPEND="${DEPEND}
		sqlite? ( || (
			( >=dev-python/pysqlite-2.0.3 <dev-lang/python-2.5 )
			>=dev-lang/python-2.5 ) )
		postgres? ( >=dev-python/psycopg-1.99 )
		mysql? ( dev-python/mysql-python )
		dev-python/reportlab
		dev-python/elementtree
		dev-python/celementtree
		app-text/scrollkeeper
		dev-python/html5lib
		dev-python/pywebkitgtk"

S="${WORKDIR}"

src_install() {
	#sed -i '9s|Network|Application;Network|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
        #sed -i '4s|Saves aoudio track from YouTube|Pulls audio tracks from YouTube videos|g' "${S}/usr/share/applications/youtube-to-mp3.desktop"
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
	rm -f "${D}"/{control,md5sums,postinst,postrm}
}