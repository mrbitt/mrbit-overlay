# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils qmake-utils

DESCRIPTION="Qt systray application written in C++/NokiaQt that show and organize your webcams"
HOMEPAGE="https://code.google.com/archive/p/webqam/"
SRC_URI="https://storage.googleapis.com/google-code-archive-downloads/v2/code.google.com/${PN}/webQam-${PV}-src.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE="doc"

DEPEND="dev-qt/qtcore:4
	dev-qt/qtgui:4
	dev-qt/qtmultimedia
	dev-qt/qtsql:4
	dev-qt/qtnetwork"
RDEPEND="${DEPEND}"

S=${WORKDIR}/webQam-${PV}

src_compile() {
	qmake webQam.pro || die "qmake failed"
	make
}

src_install() {

    dodir /usr/bin
    dodir /usr/share/{applications,icons}
    cp "bin/webQam" "${D}/usr/bin/${PN}" -rf || die "copy failed"
    cp "resources/icons/webcam.png" "${D}/usr/share/icons" -rf || die "copy failed"
    make_desktop_entry ${PN} "webqcam ${PV}" webcam.png "System;Utility"
    #sed -i '5s|Exec=webqam|Exec=webQam|g' "${D}usr/share/applications/*.desktop" || die "sed failed"
    #sed -i '6s|TryExec=webqam|TryExec=webQam|g' "${D}usr/share/applications/*.desktop" || die "sed failed"
   #emake install INSTALL_DIR="${D}"
    if use doc ; then 
      dodoc LICENSE.GPL
    fi
}
