# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4
PYTHON_DEPEND="2"

inherit eutils python

DESCRIPTION="A graphical application to monitor and manage UPSes connected to a NUT server"
HOMEPAGE="http://www.networkupstools.org/"
SRC_URI="http://www.networkupstools.org/source/2.7/nut-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="linguas_fr"

RDEPEND="sys-power/nut
        dev-util/desktop-file-utils "
DEPEND=""

S=${WORKDIR}/nut-${PV}

pkg_setup() {
	python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
    sed -i 's|Application;Network|Network|g'  scripts/python/app/nut-monitor.desktop   || die
	sed -i 's|=NUT-Monitor|=nut-monitor|'  scripts/python/app/nut-monitor.desktop
    sed -i 's|=nut-monitor.png|=nut-monitor|' scripts/python/app/nut-monitor.desktop
    sed -i 's|os.path.dirname( sys.argv\[0\] )|"/usr/share/nut-monitor"|' scripts/python/app/NUT-Monitor
    #sed -i 's|/usr/bin/env python|/usr/bin/env python2.7|' scripts/python/app/NUT-Monitor
	#epatch "${FILESDIR}"/${P}-paths.patch
	#epatch "${FILESDIR}"/${P}-paths2.patch
	python_convert_shebangs -r 2 .
}

src_install() {
  install -D -m644 scripts/python/module/PyNUT.py ${D}/usr/lib/python2.7/site-packages/PyNUT.py

  install -D -m 755 scripts/python/app/NUT-Monitor ${D}/usr/bin/nut-monitor
  install -D -m 644 scripts/python/app/nut-monitor.png ${D}/usr/share/pixmaps/nut-monitor.png
  install -D -m 644 scripts/python/app/nut-monitor.appdata.xml ${D}/usr/share/appdata/nut-monitor.appdata.xml

  install -d -m 755 ${D}/usr/share/nut-monitor/pixmaps
  install -m 644 scripts/python/app/gui-1.3.glade ${D}/usr/share/nut-monitor/
  install -m 644 scripts/python/app/pixmaps/* ${D}/usr/share/nut-monitor/pixmaps/ 

  desktop-file-install --dir=${D}/usr/share/applications scripts/python/app/nut-monitor.desktop
}
