# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="6"

inherit qmake-utils eutils toolchain-funcs

MY_PN="SocNetV"
MY_P="${MY_PN}-${PV}"

DESCRIPTION="Qt Social Network Visualizer"
HOMEPAGE="http://socnetv.sourceforge.net/"
SRC_URI="mirror://sourceforge/socnetv/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc"

DEPEND="dev-qt/qtgui:5
		dev-qt/qtwebkit:5"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

src_configure() {
	 
		eqmake5 "${PN}".pro
		make
}

src_install() {
	default
	insinto usr
	doins -r usr/bin usr/share
	
	insinto /usr/share/applications
	doins ${PN}.desktop || die "install desktop file failed"
    dobin socnetv
	
	#doicon src/images/socnetv.png
	#make_desktop_entry  ${PN} SocNetV ${PN} 'Science'
	#insinto /usr/share/${PN}/examples
	#doins nets/*
	#dodoc AUTHORS ChangeLog README TODO
	#if use doc; then
		#dohtml -r "${S}"/manual/*
	#fi
	#doman "${S}/man/${PN}.1.gz"
}
