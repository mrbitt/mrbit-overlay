# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils qmake-utils

DESCRIPTION="QT-base SDDM Configuration Editor"
HOMEPAGE="https://github.com/hagabaka/sddm-config-editor"
SRC_URI="https://github.com/hagabaka/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
S="${WORKDIR}/${P}/cpp"

LICENSE="APACHE"
SLOT="0"
KEYWORDS="~x86 amd64"
IUSE="qt5"
REQUIRED_USE="qt5"

DEPEND="qt5? (
		dev-qt/qtquickcontrols:5
	)"
RDEPEND="${DEPEND}
         x11-misc/sddm
         sys-auth/polkit"

src_prepare() {
       sed -i "6s|Qt|Qt;|g" "${S}"/data/${PN}.desktop || die "sed failed"
       sed -i -e '10d' "${S}"/data/${PN}.desktop || die "sed failed"
}

src_compile() {
	eqmake5 ${PN}.pro -r
	emake
}

src_install() {
	emake INSTALL_ROOT="${D}" install || die "Install failed!"
}
