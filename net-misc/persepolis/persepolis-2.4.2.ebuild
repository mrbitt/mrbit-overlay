# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python3_{4,5,6} )

inherit python-any-r1 eutils

DESCRIPTION="A graphical front-end for aria2 download manager with lots of features"
HOMEPAGE="	https://persepolisdm.github.io/"
SRC_URI="https://github.com/persepolisdm/persepolis/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/"${P}"

RDEPEND=""
DEPEND="${RDEPEND}
	net-misc/aria2
	virtual/pkgconfig
	x11-libs/libnotify
	dev-python/PyQt5
	dev-python/requests
	dev-python/setproctitle
	dev-qt/qtsvg:5 "
	
DOCS=( README.md LICENSE )

src_install(){
  cd "${S}"
  #python setup.py install --root="${D}" --optimize=1 || exit 1
  dodir /usr/share/persepolis	
	cp -a ./files/*  ${D}/usr/share/persepolis || die
	install -Dm755 ./persepolis ${D}/usr/bin/persepolis || die
	install -Dm644 ./persepolis.desktop ${D}/usr/share/applications/persepolis.desktop || die
	install -Dm644 ./man/persepolis.1 ${D}/usr/share/man/man1/persepolis.1 || die
	install -Dm644 ./files/icon.svg ${D}/usr/share/pixmaps/persepolis.svg || die
	install -Dm644 ./LICENSE ${D}/usr/share/licenses/persepolis/LICENSE || die
}
