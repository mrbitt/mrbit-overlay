# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler-qt4/python-poppler-qt4-0.16.3-r1.ebuild,v 1.1 2013/03/17 17:14:40 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit distutils-r1

DESCRIPTION="A tool to crop PDF files, with an eye towards eReaders."
HOMEPAGE="http://arminstraub.com/computer/krop"
SRC_URI="http://arminstraub.com/downloads/${PN}/${P}.tar.gz"

LICENSE="GPL3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/python-poppler-qt4[${PYTHON_USEDEP}]
	dev-python/pyPdf[${PYTHON_USEDEP}]"
DEPEND="${RDEPEND}"

#pkg_preinst() {
#	mkdir -p ${D}usr/share/applications
#	cp /$WORKDIR/${P}/${PN}.desktop ${D}usr/share/applications/
#	#domenu usr/share/applications/${PN}.desktop
#}
