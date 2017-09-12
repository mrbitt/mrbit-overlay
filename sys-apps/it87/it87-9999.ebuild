# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit linux-mod linux-info

DESCRIPTION="Hardware Monitoring user-space utilities"
HOMEPAGE="http://www.lm-sensors.org/ https://github.com/groeck/lm-sensors"

COMMIT="80e190105690d189c9b3510cd7e7f3d3a78d913c"
MY_PN="${PN/_/-}"

#SRC_URI="http://dl.lm-sensors.org/lm-sensors/releases/${P}.tar.bz2"
SRC_URI="https://github.com/groeck/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2+ LGPL-2.1"

# SUBSLOT based on SONAME of libsensors.so
SLOT="0/4.4.0"

KEYWORDS="alpha amd64 arm ~mips ppc ppc64 sparc x86 ~amd64-linux ~arm-linux ~x86-linux"
IUSE="sensord static-libs"

KEYWORDS="-* ~amd64 ~x86"

RESTRICT="mirror"

DEPEND="virtual/linux-sources"
RDEPEND=""

S="${WORKDIR}/${MY_PN}-${COMMIT}"

MODULE_NAMES="it87(extramodules/kernel/drivers/hwmon)"


pkg_setup() {
	
	CONFIG_CHECK="~!IT87"
	
	ERROR_IT87="IT87: If you insist on building this, you must blacklist it!"
	
	linux-mod_pkg_setup

	BUILD_PARAMS="-j1 -C ${KV_DIR} M=${S}"
	BUILD_TARGETS="clean modules"
	#convert_to_m ${S}/Makefile
}

src_install() {
	linux-mod_src_install
	dodoc README TODO
}

