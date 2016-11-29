# Copyright 2004-2014 Sabayon Linux
# Distributed under the terms of the GNU General Public License v2
# $

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit versionator python-r1

DESCRIPTION="isomd5sum provides a way of making use of the ISO9660 application data area to store md5sum data about the iso"
HOMEPAGE="http://fedorahosted.org/releases/i/s/isomd5sum"
SRC_URI="https://git.fedorahosted.org/cgit/isomd5sum.git/snapshot/${P}.tar.gz"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE=""
RDEPEND="${PYTHON_DEPS}
"
DEPEND="${RDEPEND}
"
