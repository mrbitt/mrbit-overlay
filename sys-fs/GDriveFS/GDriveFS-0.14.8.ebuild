# Copyright 2016 Jan Chren (rindeal)
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit distutils-r1


DESCRIPTION="Innovative FUSE wrapper for Google Drive"
HOMEPAGE="github.com/dsoprea/GDriveFS"
SRC_URI="https://github.com/dsoprea/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"

SLOT="0"

KEYWORDS="amd64 ~x86 ~arm"

# requirements are in `gdrivefs/resources/requirements.txt`
DEPEND="
    dev-python/fusepy[${PYTHON_USEDEP}]
	dev-python/gevent[${PYTHON_USEDEP}]
	dev-python/google-api-python-client[${PYTHON_USEDEP}]
	dev-python/greenlet[${PYTHON_USEDEP}]
	dev-python/httplib2[${PYTHON_USEDEP}]
	dev-python/python-dateutil[${PYTHON_USEDEP}]
	dev-python/six[${PYTHON_USEDEP}]
	dev-python/wsgiref
	"
RDEPEND="${DEPEND}"


src_prepare() {
	# Fix for multi threaded (issue 132)
  patch -p1 < ../../pull_147.patch

  # Add support to utf8 instead of ASCII
  patch -p1 < ../../pull_154_utf8.patch

  # Fix for oauth2client.util library
  patch -p1 < ../../issue_166.patch

  python2 setup.py build
	sed -r -e '/packages=/ s|(exclude=\[)|\1"tests.*", |' -i -- setup.py || die

	distutils-r1_src_prepare
}
