# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/quiterss/quiterss-0.13.3.ebuild,v 1.1 2013/09/04 16:28:11 pinkbyte Exp $

EAPI=5

PLOCALES="ar cs de el_GR es fa fr hu it ja ko lt nl pl pt_BR pt_PT ro_RO ru sk sr sv tg_TJ th tr uk vi zh_CN zh_TW"
inherit l10n eutils kde4-base qt4-r2

#MY_P="QuiteRSS-${PV}-src"

DESCRIPTION="A Qt4-based RSS/Atom feed reader"
HOMEPAGE="http://exmplayer.sourceforge.net/"
SRC_URI="http://ppa.launchpad.net/${PN}-dev/${PN}/ubuntu/pool/main/e/${PN}/${PN}_${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
IUSE="debug"

DEPEND="dev-db/sqlite:3
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	media-video/ffmpeg
	media-video/mplayer
	dev-qt/qtsql:4[sqlite]
	dev-qt/qtwebkit:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/ExMplayer"

DOCS=( AUTHORS HISTORY_EN HISTORY_RU README )

src_prepare() {
	cd "${S}"
	qt4-r2_src_prepare
}

src_configure() {
      cd "${S}"
        #sed -i '105s/::getuid()/QtLP_Private::getuid()/'  "${S}"/src/qtsingleapplication/qtlocalpeer.cpp || die "sed failed"
        sed -i '/#if defined(Q_OS_UNIX)/a#include <sys/types.h>' "${S}"/src/qtsingleapplication/qtlocalpeer.cpp || die "sed failed"
	#sed -i '/#include <time.h>/a#include <unistd.h>'  "${S}"/src/qtsingleapplication/qtlocalpeer.cpp || die "sed failed"
	make
	#eqmake4 PREFIX="${EPREFIX}/usr"
}


