# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-cdr/pburn/pburn-3.4.3.ebuild,v 1.3 2013/04/25 14:28:43 ssuominen Exp $

# wget --user puppy --password linux "http://www.meownplanet.net/zigbert/${P}.pet"

EAPI=4
inherit eutils

DESCRIPTION="Lets you search for files with advanced options."
HOMEPAGE="http://www.murga-linux.com/puppy/viewtopic.php?p=177950"
SRC_URI="ftp://ftp.nl.netbsd.org/vol/2/metalab/distributions/puppylinux/pet_packages-4/${P}.pet"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=x11-misc/gtkdialog-0.8.0"
DEPEND="app-arch/pet2tgz"

src_unpack() {
	pet2tgz -i "${DISTDIR}"/${P}.pet -o "${WORKDIR}"/${P}.tar.gz
	unpack ./${P}.tar.gz
}

src_prepare() {
	cat <<-EOF > "${T}"/${PN}
	#!/bin/bash
	"/usr/share/${PN}/${PN}" "\$@"
	EOF
	sed -i -e 's:usleep:/sbin/&:' usr/local/${PN}/box_splash || die
	sed -i -e 's:gtkdialog3:gtkdialog:g' usr/local/${PN}/${PN} || die
}

src_install() {
	dobin "${T}"/${PN}

	dodir /usr/share
	cp -dpR usr/local/${PN} "${D}"/usr/share || die
	#cp -dpR usr/share/doc "${D}"/usr/share || die
	
#	make_desktop_entry \
#		${PN} \
#		"Pburn CD/DVD/Blu-ray writer" \
#		/usr/share/${PN}/${PN}20.png \
#		"AudioVideo;DiscBurning"

	#dohtml -r usr/share/doc/${PN}
}
