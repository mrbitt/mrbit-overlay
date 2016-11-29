# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils

DESCRIPTION="A Free software that gathers information on CPU, motherboard and more (like CPU-Z)"
HOMEPAGE="https://github.com/X0rg/CPU-X"
LICENSE="GPL-3"

SRC_URI="https://github.com/X0rg/CPU-X/archive/v$PV.tar.gz"

KEYWORDS="~amd64 ~x86"
SLOT=0

IUSE="gtk +ncurses +cpuid +dmidecode +bandwidth +pci +system"

DEPEND="dev-util/cmake
		virtual/pkgconfig
		dev-lang/nasm"
RDEPEND="gtk? ( x11-libs/gtk+:3 )
		  ncurses? ( sys-libs/ncurses )
		  pci? ( sys-apps/pciutils )
		  system? ( sys-process/procps )
		  cpuid? ( sys-power/libcpuid )"

S="$WORKDIR/CPU-X-$PV"

QA_PRESTRIPPED="/usr/bin/cpu-x"

src_configure() {
	configuration() {
		local mycmakeargs=( -DCMAKE_BUILD_TYPE=Release
							-DCMAKE_INSTALL_PREFIX=/usr
							$(cmake-utils_use_with gtk GTK)
							$(cmake-utils_use_with ncurses NCURSES)
							$(cmake-utils_use_with pci LIBPCI)
							$(cmake-utils_use_with system LIBSYSTEM)
							$(cmake-utils_use_with cpuid LIBCPUID)
							$(cmake-utils_use_with dmidecode LIBDMI)
							$(cmake-utils_use_with bandwidth LIBBDWT) )

		cmake-utils_src_configure
	}
	configuration
}

src_compile() {
	cmake-utils_src_make
}

src_install() {
	cmake-utils_src_install
}
