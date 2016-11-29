# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-misc/rodent/rodent-5.1.4.ebuild,v 1.3 2013/04/11 18:09:03 ago Exp $

EAPI=5
EAUTORECONF=yes
inherit eutils autotools-utils

DESCRIPTION="A fast, small and powerful file manager and graphical shell"
HOMEPAGE="http://rodent.xffm.org/"
SRC_URI="mirror://sourceforge/xffm/${PN}/${P}.tar.bz2"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="bcrypt nfs sshfs bluetooth ftp ecryptfs cifs"

COMMON_DEPEND="
	x11-libs/librfm5
"
RDEPEND="${COMMON_DEPEND}
	sshfs? ( sys-fs/sshfs-fuse )
	nfs? ( net-fs/nfs-utils )
	ecryptfs? ( sys-fs/ecryptfs-utils )
	bluetooth? ( 
		sys-fs/obexfs
		net-wireless/bluez
		)
	cifs? ( net-fs/samba )
	bcrypt? ( app-crypt/bcrypt )
"
DEPEND="
	${COMMON_DEPEND}
"


src_prepare() {
	eautoconf
	elibtoolize
}

src_configure() {
    # Options not unset by use flags:
	#   --enable-completion
	#   --enable-ecombo
	#   --enable-props
	#   --enable-mime
	#   --enable-mmagic
	#   --enable-zmagic
	#   --enable-icon
	#   --enable-fstab
	#   --enable-ps
	#   --enable-fuse
	#   --enable-
	#   --enable-
	econf \
		use_enable bcrypt \
		use_enable nfs \
		use_enable sshfs \
		use_enable bluetooth \
		use_enable ftp \
		use_enable ecryptfs \
		use_enable cifs
}

src_compile() {
	pushd $BUILD_DIR
	emake -C DESTDIR=${D} -j2
	popd
}

src_install() {
	pushd $BUILD_DIR
	emake -C DESTDIR=${D} install
	dodoc ChangeLog README TODO COPYING NEWS AUTHORS

}


