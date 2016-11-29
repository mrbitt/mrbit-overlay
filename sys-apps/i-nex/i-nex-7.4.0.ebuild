# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 

EAPI=5

inherit eutils autotools versionator 

DESCRIPTION="A Gambas software that gathers information on CPU, motherboard and more (like CPU-Z)"
HOMEPAGE="http://i-nex.linux.pl/"
SRC_URI="https://github.com/eloaders/I-Nex/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-lang/gambas:3
	media-libs/mesa
	net-misc/curl
	sys-power/libcpuid
	sys-apps/pciutils
	sys-apps/lsb-release
	sys-fs/udisks:0
	dev-python/configobj
	x11-misc/xdg-utils"
DEPEND="${RDEPEND}"

S=${WORKDIR}/I-Nex-${PV}

RESTRICT="strip"

src_prepare() {
   sed -i 's|python3$|python2|' pastebinit
  # make it dynamic
  sed -i -e 's|^STATIC.*|STATIC = false|' i-nex.mk
  sed -i -e 's|^UDEV_RULES_DIR.*|UDEV_RULES_DIR = /usr/lib/udev/rules.d|' i-nex.mk
  cd "I-Nex"
  autoreconf -i
}
 
src_compile() {
  
  cd "${S}/I-Nex"
  ./configure --prefix=/usr
  cd ..
  make
}
 
src_install() {
    emake DESTDIR="${D}/" install
    sed -i -e '1d' "${D}"/usr/share/applications/${PN}-library.desktop || die "sed failed"
    #einstalldocs
}

