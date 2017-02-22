# Lara Maia <dev@lara.click> 2014~2016
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit cmake-utils

DESCRIPTION="Gathers information on CPU, motherboard and more (like CPU-Z)"
HOMEPAGE="https://github.com/X0rg/$PN"
LICENSE="GPL-3"

SRC_URI="https://github.com/X0rg/$PN/archive/v$PV.tar.gz"

KEYWORDS="amd64 ~x86"
SLOT=0
IUSE="gtk +gettext +ncurses +cpuid +dmidecode +bandwidth +pci +system curl wget"
RESTRICT="primaryuri"

DEPEND="dev-util/cmake
		virtual/pkgconfig
		dev-lang/nasm"
RDEPEND="gtk? ( x11-libs/gtk+:3 )
		gettext? ( sys-devel/gettext )
		ncurses? ( sys-libs/ncurses )
		pci? ( sys-apps/pciutils )
		system? ( sys-process/procps )
		cpuid? ( >=dev-libs/libcpuid-0.4.0 )
		cpuid? ( >=dev-libs/libcpuid-0.4.0 )
		curl? ( net-misc/curl )
		wget? ( net-misc/wget )"

S="$WORKDIR/CPU-X-$PV"

QA_PRESTRIPPED="/usr/bin/$PN"

src_configure() {
	configuration() {
		local mycmakeargs=( -DCMAKE_BUILD_TYPE=Release
							-DCMAKE_INSTALL_PREFIX=/usr
							$(cmake-utils_use_with gtk GTK)
							$(cmake-utils_use_with gettext GETTEXT)
							$(cmake-utils_use_with ncurses NCURSES)
							$(cmake-utils_use_with pci LIBPCI)
							$(cmake-utils_use_with system LIBSYSTEM)
							$(cmake-utils_use_with cpuid LIBCPUID)
							$(cmake-utils_use_with dmidecode LIBDMI)
							$(cmake-utils_use_with bandwidth LIBBDWT)
							$(cmake-utils_use_with curl LIBCURL) )

		cmake-utils_src_configure
	}
	configuration
}
