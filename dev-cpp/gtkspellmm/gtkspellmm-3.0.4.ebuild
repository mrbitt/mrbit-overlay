# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils

DESCRIPTION="gtkspell C++ bindings"
HOMEPAGE="http://gtkspell.sourceforge.net/"
SRC_URI="http://sourceforge.net/projects/gtkspell/files/${PN}/${P}.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="
	app-text/gtkspell:3
"
RDEPEND="${DEPEND}"

