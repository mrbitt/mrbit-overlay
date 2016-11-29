# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-3.1.2.ebuild,v 1.2 2013/09/05 18:46:59 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3,3_4,3_5} )
#PYTHON_DEPEND="3"
#SUPPORT_PYTHON_ABIS="1"

inherit distutils-r1 eutils

DESCRIPTION="A system tray application for the weather status"
HOMEPAGE="http://opendesktop.org/content/show.php/meteo-qt?content=167733"
SRC_URI="https://github.com/dglent/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND="
	dev-python/urllib3
	dev-python/lxml[${PYTHON_USEDEP}]
	dev-python/setuptools"
DEPEND="${RDEPEND}
	( dev-python/PyQt5[gui,widgets] )
	dev-python/sip"


