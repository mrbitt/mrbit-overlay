# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

KEYWORDS="~amd64 ~ppc ~x86 ~amd64-linux"

#KDE_REQUIRED="optional"
inherit kde4-base

DESCRIPTION="Set of tools to manage and organize your optical discs like CDs, DVDs and Blu-ray"
HOMEPAGE="http://getsilicon.org/"
SRC_URI="http://getsilicon.org/download/silicon-${PV}-src.tar.gz"
LICENSE="GPL-3"
SLOT="4"
IUSE="debug kde"

DEPEND="
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	kde? ( $(add_kdebase_dep kdelibs) )
"
RDEPEND="${DEPEND}
	sys-fs/fuseiso
	media-libs/phonon
	media-libs/taglib
	app-cdr/cdrkit
"

RESTRICT="!kde? ( test )"

S=${WORKDIR}/${P}-src

src_configure() {
	cd "${S}"
	kde4-base_src_configure
	}

src_compile() {
	cd "${S}"
	kde4-base_src_compile
	}

src_install() {
	cd "${S}"
	kde4-base_src_install
	}

src_test() {
	cd "${S}"
	kde4-base_src_test
	}
