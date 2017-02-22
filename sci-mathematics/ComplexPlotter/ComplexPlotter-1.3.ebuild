# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6


inherit cmake-utils

DESCRIPTION="Featureful and configurable Qt client for the music player daemon (MPD)"
HOMEPAGE="https://github.com/CDrummond/cantata"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1487678987/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND="
	dev-qt/qtcore:5
	dev-qt/qtgui:5[gles2]
	dev-qt/qtsql:5
	dev-qt/qtwidgets:5
	virtual/opencl
"
DEPEND="${RDEPEND} "
