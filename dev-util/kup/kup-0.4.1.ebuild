# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde4-base

DESCRIPTION="Kup Backup System"
HOMEPAGE="http://http://kde-apps.org/content/show.php/Kup+Backup+System?content=147465"
SRC_URI="http://kde-apps.org/CONTENT/content-files/147465-${P}.tar.gz"

IUSE="kup rsync"
LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="dev-qt/qtcore:4
	>=kde-base/kdelibs-4.4:4[aqua=]"

RDEPEND="${DEPEND}"
