# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

DESCRIPTION="is yet another Qt5/KF5 application that uses gmail atom feed to report if a user has new email in their gmail accounts"
HOMEPAGE="http://mhogomchungu.github.io/qCheckGMail/"
SRC_URI="https://github.com/mhogomchungu/qCheckGMail/archive/${PV}.tar.gz -> {P}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit kde5 cmake-utils 

KEYWORDS="amd64 x86"

RDEPEND=""
DEPEND="${RDEPEND}
    dev-qt/qtcore:5
    "
    
S=${WORKDIR}/qCheckGMail-${PV}
#RESTRICT="strip"


