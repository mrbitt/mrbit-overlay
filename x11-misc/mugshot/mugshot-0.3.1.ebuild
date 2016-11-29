
# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
PYTHON_COMPAT=( python3_4 )
EPYTHON=python3.4

inherit distutils-r1

DESCRIPTION="Program to update personal user details"
HOMEPAGE="https://launchpad.net/mugshot"
SRC_URI="https://launchpad.net/${PN}/0.3/${PV}/+download/${PN}-${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64"
IUSE="accountsservice pidgin webcam"

DEPEND="dev-python/pygobject
		dev-python/pexpect
		dev-python/dbus-python
		dev-python/python-distutils-extra
		pidgin? ( net-im/pidgin )
		accountsservice? ( sys-apps/accountsservice )
		webcam? ( =media-libs/gst-plugins-good-0.10* )
"
RDEPEND="${DEPEND}"

pkg_postinst() {
	insinto /usr/share/glib-2.0/schemas
	doins ${S}/data/glib-2.0/schemas/apps.mugshot.gschema.xml
	einfo "Compiling Glib schemas"
	glib-compile-schemas "/usr/share/glib-2.0/schemas/"

}

pkg_postrm() {
	einfo "Compiling Glib schemas"
	glib-compile-schemas "/usr/share/glib-2.0/schemas/"
}

