# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PLOCALES="fr es it ru uk_UA uz_UZ"
inherit l10n qt4-r2 subversion

DESCRIPTION="Qt4 cross-platform download manager"
HOMEPAGE="http://code.google.com/p/rexloader/"
ESVN_REPO_URI="http://rexloader.googlecode.com/svn/trunk"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE="+httploader +hashcalc +notify"

DEPEND="
	dev-qt/qtgui:4
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtscript:4
	dev-qt/qtsql:4
	dev-qt/qtwebkit:4
	dev-qt/qtdbus:4
	>=sys-libs/zlib-1.2.3"
RDEPEND="${DEPEND}"

MY_P="REXLoader"

src_configure() {
        sed -i '3s/#FtpLoader/FtpLoader/g' ${S}/plugins/plugins.pro || die "sed failed"
	sed -i '6s/NixNotifyPlugin/NixNotifyPlugin NoticeWindow/g' ${S}/plugins/plugins.pro || die "sed failed"
	einfo "Nothing to customize."
}

src_compile() {
	cd "${S}/${MY_P}" && eqmake4 && qt4-r2_src_compile
	use httploader && cd "${S}"/plugins/HttpLoader && eqmake4 && qt4-r2_src_compile
	use hashcalc && cd "${S}"/plugins/HashCalculator && eqmake4 && qt4-r2_src_compile
	use notify && cd "${S}"/plugins/NixNotifyPlugin && eqmake4 && qt4-r2_src_compile
	cd "${S}"/plugins && eqmake4 && qt4-r2_src_compile
	#use ftploader && cd "${S}"/plugins/Ftploader && eqmake4 && qt4-r2_src_compile
	#use notice && cd "${S}"/plugins/NoticeWindow && eqmake4 && qt4-r2_src_compile
}

src_install() {
	dobin usr/bin/${PN}
	use httploader || use hashcalc || use notify \
	&& exeinto /usr/lib/${PN}/plugins/ \
	&& doexe usr/lib/${PN}/plugins/*.so
	insinto /usr/share/${PN}/locale
	doins -r usr/share/${PN}/locales/*
	l10n_for_each_disabled_locale_do rm_loc
	doicon ${MY_P}/${PN}.png
	domenu ${MY_P}/${PN}.desktop
}

rm_loc() {
	rm "${ED}/usr/share/${PN}/locale/${1}.qm" || die
}