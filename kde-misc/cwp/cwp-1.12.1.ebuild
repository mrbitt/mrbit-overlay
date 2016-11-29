# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit kde5 cmake-utils

DESCRIPTION="KDE4 Customizable weather plasmoid."
HOMEPAGE="http://kde-look.org/content/show.php?content=98925"
SRC_URI="http://kde-look.org/CONTENT/content-files/98925-${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="debug"

DEPEND="kde-plasma/plasma-workspace"
RDEPEND="${DEPEND}"



src_install() {
      cmake-utils_src_install
      #kde4-base_src_install
      #mv ${D}/usr/share/apps  ${D}/usr/share/kde4/ || die
}
