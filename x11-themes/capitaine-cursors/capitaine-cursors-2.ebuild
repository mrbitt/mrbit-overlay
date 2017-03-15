# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit eutils

DESCRIPTION="An x-cursor theme inspired by macOS and based on KDE Breeze"
HOMEPAGE="https://github.com/keeferrourke/capitaine-cursors"
SRC_URI="https://github.com/keeferrourke/capitaine-cursors/archive/r2.tar.gz -> ${PN}-r${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-r${PV}"

src_install(){
	insinto /usr/share/icons/Capitaine
	doins -r bin/xcursors/*
    find ${D} -type f -exec chmod 644 {} \;
}
