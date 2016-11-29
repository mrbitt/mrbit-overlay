# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit cmake-utils

DESCRIPTION="A tesseract OCR front-end"
HOMEPAGE="http://www.sourceforge.com/projects/gimagereader"
#SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"
SRC_URI="http://downloads.sourceforge.net/project/${PN}/${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="scanner"

DEPEND="
	app-text/tesseract
	app-text/qtspell
	app-text/poppler
	scanner? ( media-gfx/sane-backends )"
