# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"
PYTHON_COMPAT=( python{3_2,3_3,3_4,3_5} )

#PYTHON_DEPEND="2"
#SUPPORT_PYTHON_ABIS="1"
#RESTRICT_PYTHON_ABIS="3.*"

inherit distutils-r1 versionator

MY_PV="$(get_version_component_range 1-2)"

DESCRIPTION="Linux Backup, Done Right"
HOMEPAGE="https://launchpad.net/time-drive"
SRC_URI="http://launchpad.net/${PN}/${MY_PV}/${MY_PV}/+download/Time-Drive-${PV}.zip"

SLOT="0"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
LICENSE="GPL-2"
IUSE=""

RDEPEND="
	app-backup/duplicity
	dev-python/PyQt4"
DEPEND="app-arch/unzip"

#PYTHON_MODNAME="timedrive"

