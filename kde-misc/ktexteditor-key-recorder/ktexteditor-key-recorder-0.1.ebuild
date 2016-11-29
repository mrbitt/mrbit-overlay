# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
KDE_MINIMAL=4.8

inherit kde4-base

DESCRIPTION="Katepart plugin to record and replay a key sequence"
HOMEPAGE="http://opendesktop.org/content/show.php/ktexteditor-key-recorder?content=169432"
SRC_URI="http://opendesktop.org/CONTENT/content-files/169432-${PN}.tar.gz"

IUSE=""
LICENSE="LGPL"
SLOT="4"
KEYWORDS="~amd64 ~x86"

DEPEND="
	$(add_kdebase_dep kate)"
RDEPEND="${DEPEND}"

S=${WORKDIR}