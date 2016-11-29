# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=6

inherit kde5

LANGS=" de es fr it lt pl pt_BR ru sv tl zh_TW"
inherit  eutils cmake-utils

DESCRIPTION="Qt5 Kup Backup System"
HOMEPAGE="http://http://kde-apps.org/content/show.php/Kup+Backup+System?content=147465"
SRC_URI="https://github.com/spersson/Kup/archive/${P}.tar.gz"

IUSE="bup rsync ${LANGS// / linguas_}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
    dev-qt/qtcore:5
    dev-qt/qtwidgets:5
    kde-frameworks/kcoreaddons:5
    kde-frameworks/kdbusaddons:5
    kde-frameworks/ki18n:5 
    kde-frameworks/solid:5
    kde-frameworks/kidletime:5
    kde-frameworks/knotifications:5
    kde-frameworks/kiconthemes:5
    kde-frameworks/kinit:5
    kde-frameworks/kconfig:5 "

RDEPEND="${DEPEND}
         rsync? ( net-misc/rsync )
         bup? ( app-backup/bup )
         "

S=${WORKDIR}/Kup-${P}

