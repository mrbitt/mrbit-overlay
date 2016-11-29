# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit autotools git-2

DESCRIPTION="Customized version of xpdf with the use of the poppler library"
HOMEPAGE="https://github.com/bircoph/xpdf-poppler"
EGIT_REPO_URI="git://github.com/bircoph/xpdf-poppler.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE=""

DOCS=( README.md )

RDEPEND="app-text/poppler"
DEPEND="${RDEPEND}
	virtual/pkgconfig"

src_prepare(){
	eautoreconf
}
