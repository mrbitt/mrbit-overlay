# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils cmake-utils

DESCRIPTION="A note-taking KDE application with the power of lightweight markup language"
HOMEPAGE="https://github.com/sadhen/marketo"
SRC_URI="https://github.com/sadhen/marketo/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug"

DEPEND="x11-themes/hicolor-icon-theme
	kde-frameworks/kdewebkit
	=dev-libs/libmdcpp-9999
	kde-frameworks/ktexteditor:5
	kde-frameworks/kdewebkit:5
	dev-qt/qtcore:4
	dev-qt/qtgui:4"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"


