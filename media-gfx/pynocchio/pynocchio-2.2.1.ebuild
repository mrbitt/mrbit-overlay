# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

PYTHON_COMPAT=( python3_{4,5,6} )

inherit distutils-r1 eutils gnome2-utils xdg ${GIT_ECLASS}

DESCRIPTION="Qt4/Qt5-based image viewer specialized in manga/comic reading"
HOMEPAGE="https://github.com/pynocchio/pynocchio"
if [[ ${PV} == *9999* ]];then
	GIT_ECLASS="git-r3"
	EGIT_REPO_URI="${HOMEPAGE}"
	KEYWORDS=""
else
	SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ~x86"
	RESTRICT="mirror"
fi

LICENSE="LGPL-3.0"
SLOT="0"
IUSE="+designer"

DEPEND="
	dev-python/pyside[X,designer?,${PYTHON_USEDEP}]
	dev-python/pyside-tools[${PYTHON_USEDEP}]
	dev-python/rarfile[${PYTHON_USEDEP}]
	dev-python/peewee[${PYTHON_USEDEP}]
	dev-qt/linguist:5
	dev-python/PyQt5[sql,designer?,${PYTHON_USEDEP}]
	dev-qt/qtsql:5[sqlite]
	app-arch/unrar-gpl
"
RDEPEND="${DEPEND}
	dev-python/setuptools[${PYTHON_USEDEP}]"

S="${WORKDIR}/${P}"

	src_prepare() {
	sed -i "s:Icon=pynocchio.png:Icon=pynocchio.png;:" linux/applications/${PN}.desktop || die
	sed -i "s:Exec=pynocchio:Exec=pynocchio-client.py:" linux/applications/${PN}.desktop || die
	eapply_user
}	

pkg_preinst() {
	xdg_pkg_preinst
	gnome2_icon_savelist
}

pkg_postinst() {
	xdg_pkg_postinst
	gnome2_icon_cache_update
}

pkg_postrm() {
	xdg_pkg_postrm
	gnome2_icon_cache_update
}
