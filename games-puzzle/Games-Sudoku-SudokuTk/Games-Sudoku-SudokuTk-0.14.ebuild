# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit perl-app

DESCRIPTION="Sudoku game Perl"
HOMEPAGE="http://www.cpan.org/modules/01modules.index.html"
SRC_URI="http://www.cpan.org/authors/id/C/CG/CGUINE/${P}.tar.gz"
LICENSE="GPL-3 LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-perl/Tk
	 virtual/perl-IO"
DEPEND="${RDEPEND}
	"
src_prepare() {
        cat <<-EOF > "${T}"/${PN}
	#!/bin/bash
	perl /usr/bin/${PN}.t
	EOF
}
	
src_install() {
	perl-module_src_install
	dodoc
	dobin ${S}/t/${PN}.t
        dobin "${T}"/${PN}
	 #newbin ${S}/t/${PN}.t ${PN}
	convert ${S}/lib/Games/Sudoku/photos/sudoku.bmp -scale 48x48 sudoku.png || die "convert failed"
	doicon sudoku.png 
	make_desktop_entry \
		${PN} \
		"Sudoku game Perl" \
		sudoku.png \
		"Game;LogicGame"
}
