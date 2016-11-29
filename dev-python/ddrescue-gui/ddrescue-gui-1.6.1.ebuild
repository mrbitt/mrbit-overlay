# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

PYTHON_COMPAT=( python2_7 )
inherit eutils python-single-r1

SRC_URI="https://launchpad.net/${PN}/1.x/${PV}/+download/${PN}_${PV}~otherdistro-0ubuntu1~ppa1.tar.gz"
KEYWORDS="~amd64 ~x86"

DESCRIPTION="A simple GUI frontend to make gddrescue easier to use"
HOMEPAGE="https://launchpad.net/ddrescue-gui"

LICENSE="AGPL-3"
SLOT="0"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	>=dev-python/setuptools-0.6.34[${PYTHON_USEDEP}]
	dev-python/wxpython
	dev-python/beautifulsoup
	sys-fs/ddrescue
	sys-apps/coreutils
	sys-apps/grep
	sys-process/psmisc
	sys-block/parted
	sys-apps/util-linux
	x11-libs/libnotify
	sys-apps/lshw
"
DEPEND="${RDEPEND}"

REQUIRED_USE="${PYTHON_REQ_USE}"

S="${WORKDIR}/${P}"

src_install() {
          #dodir /usr/bin
          dodir /usr/share/{applications,pixmaps,"${PN}"}
          cp "${S}"/*.desktop "${D}"/usr/share/applications/
          cp "${S}"/*.png "${D}"/usr/share/pixmaps/
          cp -R "${S}"/{Tools,GetDevInfo,images,other,AuthenticationDialog.py,DDRescue-GUI.py} "${D}"/usr/share/${PN}/
}
