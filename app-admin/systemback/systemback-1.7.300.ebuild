# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-news/quiterss/quiterss-0.17.7.ebuild,v 1.1 2015/04/21 16:34:29 maksbotan Exp $

EAPI=5

PLOCALES=" ar_EG ca_ES cs da_DK de en_GB es fi fr gl hu id pt_BR ro ru tr uk zh_CN "
PLOCALE_BACKUP="en_GB"
MY_P="${PN}"_"${PV}"

inherit eutils l10n fdo-mime gnome2-utils qmake-utils

DESCRIPTION="Simple system backup and restore application with extra features"
HOMEPAGE="http://sourceforge.net/projects/systemback"
SRC_URI="http://sourceforge.net/projects/${PN}/files/1.7/${PN}_${PV}_source.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86 ~amd64-linux ~x86-linux"
LANGS="ar_EG ca_ES cs da_DK de en_GB es fi fr gl hu id pt_BR ro ru tr uk zh_CN"
IUSE="debug +qt5 +nls"

for lang in ${LANGS}; do
	IUSE+=" linguas_${lang}"
done

RDEPEND="
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtmultimedia:5
		dev-qt/qtnetwork:5
		dev-qt/qtprintsupport:5
		dev-qt/qtsql:5[sqlite]
		dev-qt/qtwebkit:5
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
	sys-libs/ncurses
	sys-fs/squashfs-tools
	dev-qt/qtsingleapplication[qt5]
	dev-db/sqlite:3
"
DEPEND="${RDEPEND}
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

S="${WORKDIR}/${MY_P}"

#DOCS=( AUTHORS HISTORY_EN HISTORY_RU README )


gen_translation() {
	lrelease ${PN}_${1}.ts
	eend $? || die "failed to generate $1 translation"
}

install_locale() {
	insinto /usr/share/${PN}/lang
	doins "${S}"/lang/${PN}_${1}.qm
	eend $? || die "failed to install $1 translation"
}

src_configure() {
	eqmake5 PREFIX="${EPREFIX}/usr" 
	sed -i "43s|lncursesw|lncursesw -ltinfo|g" systemback-cli/systemback-cli.pro || die "sed failed"
	emake
	cd "${S}"/lang
	l10n_for_each_locale_do gen_translation
}

src_install() {
        dodir /usr/{bin,lib/systemback,share/systemback/lang}
        dodir /usr/share/icons/hicolor
        cp -pPR ${S}/icons/* "${D}"/usr/share/icons/hicolor
        dodir /etc/xdg/autostart
        cp sbschedule*.desktop "${D}"/etc/xdg/autostart
        cp systemback-cli/systemback-cli "${D}"/usr/bin
        cp systemback/systemback "${D}"/usr/bin
        cp sbsysupgrade/sbsysupgrade "${D}"/usr/lib/systemback/
        cp efi*.* "${D}"/usr/lib/systemback/
        cp sbsustart/sbsustart "${D}"/usr/lib/systemback/
        cp sbscheduler/sbscheduler "${D}"/usr/lib/systemback/
        cp libsystemback/libsystemback.* "${D}"/usr/lib/systemback/ && rm -f "${D}"/usr/lib/systemback/libsystemback.pro
        doicon logo.png || die "doicon failed"
	#emake DISTDIR="${D}" install
	l10n_for_each_locale_do install_locale
	einstalldocs
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}