# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
PYTHON_DEPEND="2"

MY_PN=TeXamator

DESCRIPTION="A program aimed at helping you making your exercise sheets"
HOMEPAGE="http://alexisfles.ch/en/texamator/texamator.html"

if [[ ${PV} == *9999* ]]; then
	inherit git-r3 eutils multilib python
	EGIT_REPO_URI="https://github.com/alexisflesch/${PN}.git"
# 	EGIT_COMMIT=""
    S=${WORKDIR}/${P}
else
    inherit eutils multilib python
    SRC_URI="https://dl.opendesktop.org/api/files/download/id/1485555001/${PN}-master.zip -> ${P}.zip"
    S=${WORKDIR}/${PN}-master

fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-text/dvipng
	dev-python/PyQt4
	virtual/latex-base"
RDEPEND="${DEPEND}"

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_install() {
	python_need_rebuild
    
    dobin "${FILESDIR}"/${PN}
 
	insinto /usr/$(get_libdir)/${PN}
	doins -r ${PN}.py partielatormods {ts,ui}_files
	
	newicon ui_files/icones/${MY_PN}.png  ${PN}.png||  die "doicons failed!"
	make_desktop_entry ${PN} ${PN} ${PN} "Office;X-Misc;X-Text;"
}

pkg_postinst() {
	python_mod_optimize /usr/$(get_libdir)/${PN}
}

pkg_postrm() {
	python_mod_cleanup /usr/$(get_libdir)/${PN}
}
