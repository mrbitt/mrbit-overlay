# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit cmake-utils flag-o-matic versionator

PB=$(get_version_component_range -2)


DESCRIPTION="is a graphical interface to configure the GRUB2/BURG settings and menuentries"
HOMEPAGE="https://launchpad.net/grub-customizer"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="debug gtk2 +gtk3"

SRC_URI="gtk3? ( https://launchpad.net/${PN}/${PB}/${PV}/+download/${PN}_${PV}.tar.gz )
         gtk2? ( https://launchpad.net/${PN}/${PB}/${PV}/+download/${PN}_${PV}.gtk2.tar.gz )"

DEPEND="sys-devel/gettext
	app-arch/libarchive
	x11-themes/hicolor-icon-theme
        dev-libs/openssl
	gtk2? ( dev-cpp/gtkmm:2.4 )
	gtk3? ( dev-cpp/gtkmm:3.0 ) "
RDEPEND="${DEPEND}
	sys-boot/grub:2 "

S="${WORKDIR}/${P}"

DOCS=( README changelog )

src_install() {
	cmake-utils_src_install
	insinto /etc/grub-customizer
	newins "${FILESDIR}/grub.cfg" grub.cfg
}