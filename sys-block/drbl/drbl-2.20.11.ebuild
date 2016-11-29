# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4
DESCRIPTION="DRBL (Diskless Remote Boot in Linux) is free software, open source solution to managing the deployment of the GNU/Linux operating system across many clients"

SRC_URI="http://free.nchc.org.tw/drbl-core/src/testing/${PN}-${PV}.tar.bz2"
SLOT="0"
LICENSE="GPL3"
KEYWORDS="~x86 ~amd64"
DEPEND=""
RDEPEND="${DEPEND}"

src_install() {
        emake install DESTDIR="${D}"
}
