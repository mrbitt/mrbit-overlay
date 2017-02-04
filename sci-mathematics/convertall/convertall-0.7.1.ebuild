# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
_Ver=1486243960
PYTHON_COMPAT=( python3_4 )

inherit eutils python-single-r1 l10n toolchain-funcs

DESCRIPTION="Is a unit conversion python program"
HOMEPAGE="www.linux-apps.com/p/1127977/"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/${_Ver}/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/ConvertAll

RDEPEND="${PYTHON_DEPS}
    dev-python/ordereddict[${PYTHON_USEDEP}]
	dev-python/PyQt5[${PYTHON_USEDEP}]
	dev-qt/qtcore:5"

LANGS="es de fr it ru xx"
for x in ${LANGS}; do
	IUSE+="linguas_${x} "
done

pkg_setup() {
	python-single-r1_pkg_setup
}

src_install() {
	cd "${S}"
	dodir /usr
	./install.py -p "${D}"/usr ||  die "install failed!"

	cat <<EOF >"${D}"/usr/bin/${PN}
#!/bin/sh
exec python3 /usr/share/${PN}/${PN}.py "$@"
EOF
fperms 0755 /usr/bin/${PN}

    newicon icons/${PN}_med.png  ${PN}.png||  die "doicons failed!"
	make_desktop_entry ${PN} ${PN} ${PN} "Education;Math;"
	#domenu "${FILESDIR}"/${PN}.desktop
}

