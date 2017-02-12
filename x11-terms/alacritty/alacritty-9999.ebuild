# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cargo eutils git-r3

DESCRIPTION=""
HOMEPAGE="https://github.com/jwilm/alacritty"
EGIT_REPO_URI="https://github.com/jwilm/alacritty"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE=""

CDEPEND="
	media-libs/fontconfig"
DEPEND="$CDEPEND
	>=dev-lang/rust-1.15.0
	media-libs/fontconfig
	x11-misc/xclip"
RDEPEND="${CDEPEND}"

cargo_src_install() {
	default
	insinto /usr/bin
	doins target/release/alacritty && chmod +x "${D}/usr/bin/alacritty"
	#doexe target/release/alacritty 
	sed -i -e "s|TerminalEmulator|TerminalEmulator;|g" Alacritty.desktop || die
    insinto /usr/share/applications
    doins Alacritty.desktop 
}

