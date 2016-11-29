# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Fight Flash Fraud, or Fight Fake Flash"
HOMEPAGE="http://oss.digirati.com.br/f3/"
SRC_URI="https://github.com/AltraMayor/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_compile() {
	emake linux
}

src_install() {
	dobin f3write
	dobin f3read
	dodoc README
}
