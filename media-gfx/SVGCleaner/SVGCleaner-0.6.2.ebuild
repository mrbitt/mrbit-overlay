# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils kde4-base qt4-r2 git-2
DESCRIPTION="SVG Cleaner cleans up your SVG files from unnecessary data."
HOMEPAGE="http://qt-apps.org/content/show.php?action=content&content=147974 https://github.com/RazrFalcon/SVGCleaner"
EGIT_REPO_URI="https://github.com/RazrFalcon/SVGCleaner.git"

if [[ ${PV} == *9999* ]]; then
	inherit git-2
	EGIT_REPO_URI="git://github.com/RazrFalcon/${PN}.git"
	EGIT_BRANCH="master"
	KEYWORDS=""
	S="${WORKDIR}/${PN}"
else
	SRC_URI="https://github.com/RazrFalcon/${PN}/archive/v${PV}.zip -> ${P}.zip"
	KEYWORDS="~arm ~amd64 ~x86"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="
app-arch/p7zip
>=dev-qt/qtsvg-4.6"
RDEPEND="${DEPEND}"


src_compile() {
	cd ${P}
	eqmake4 svgcleaner.pro
	make
	#eqmake || die "Make failed!"
}
src_install() {
        cd  ${P}
	emake INSTALL_ROOT="${D}" install || die "Install failed"
	dodir /usr/share/${PN}
	mv  "${S}"/bin/*.qm "${D}"usr/share/${PN}/ || die "Install failed"
	cp -pPR "${S}"/bin "${D}"/usr/bin || die "Install failed"
	dodoc README
	dodoc INSTALL
}
