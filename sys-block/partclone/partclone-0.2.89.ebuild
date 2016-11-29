# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Partition cloning tool"
HOMEPAGE="http://partclone.org"
SRC_URI="http://sourceforge.net/projects/partclone/files/stable/${PV}/partclone_${PV}.orig.tar.gz/download -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="static +extfs +fat exfat hfs -jfs +ntfs -reiserfs reiser4 ufs xfs f2fs nilfs2 minix vmfs btrfs"

# xfsprogs, see https://bugs.gentoo.org/show_bug.cgi?id=486514

DEPEND="reiserfs? ( sys-fs/progsreiserfs )
	exfat? ( sys-fs/exfat-utils )
	ntfs? ( sys-fs/ntfs3g )
	extfs? ( sys-libs/e2fsprogs-libs )
	reiser4? ( sys-fs/reiser4progs )
	reiserfs? ( sys-fs/progsreiserfs )
	xfs? ( sys-fs/xfsprogs )
	ufs? ( sys-fs/ufsutils )
	jfs? ( sys-fs/jfsutils )
	btrfs? ( sys-fs/btrfs-progs )
	nilfs2? ( >=sys-fs/nilfs-utils-2.1.5-r1 )
	f2fs? ( >=sys-libs/e2fsprogs-libs-1.42.13 )
	static? ( sys-fs/e2fsprogs[static-libs]
			sys-libs/e2fsprogs-libs[static-libs]
			sys-fs/xfsprogs[static-libs]
			sys-libs/ncurses[static-libs]
			sys-fs/ntfs3g[static-libs] )"
			
RDEPEND="${DEPEND}
			virtual/pkgconfig "

src_unpack()
{
	unpack ${A}
	#epatch "${FILESDIR}/${PN}-xfslib.patch"
	cd ${S}
}

src_prepare() {
	# TODO: remove in >0.2.89 release
	epatch "${FILESDIR}"/0.2.89-autoconf_fix_disable_option_handling.patch
	default

	eautoreconf
	#sed -i '/SUBDIRS/s/tests//' "${S}/Makefile.am" || die
	#sed -i 's/sizeof(badsector_magic)/(strlen(badsector_magic) + 1)/' "${S}/src/partclone.c" || die
	#autotools-utils_src_prepare
}

src_configure() {
	ocal myconf
	myconf="${myconf} --enable-extfs --enable-ncursesw --enable-fs-test"
	use xfs && myconf="${myconf} --enable-xfs"
	use reiserfs && myconf="${myconf} --enable-reiserfs"
	use reiser4 && myconf="${myconf} --enable-reiser4"
	use hfs && myconf="${myconf} --enable-hfsp"
	use fat && myconf="${myconf} --enable-fat --enable-exfat"
	use ntfs && myconf="${myconf} --enable-ntfs"
	use minix && myconf="${myconf} --enable-minix"
	use jfs && myconf="${myconf} --enable-jfs"
	use btrfs && myconf="${myconf} --enable-btrfs"
	use vmfs && myconf="${myconf} --enable-vmfs"
	use f2fs && myconf="${myconf} --enable-f2fs"
	use nilfs2 && myconf="${myconf} --enable-nilfs2"
	use static && myconf="${myconf} --enable-static"
	use ufs && myconf="${myconf} --enable-ufs"
	
	econf ${myconf} || die "econf failed"
	emake || die "make failed"
}

src_install()
{
	#emake install || die "make install failed"
	#emake DIST_ROOT="${D}" install || die "make install failed"
	cd ${S}/src
	dosbin partclone.dd partclone.restore partclone.chkimg partclone.info partclone.imager
	dosbin partclone.extfs
	dosym /usr/sbin/partclone.extfs /usr/sbin/partclone.ext4
	dosym /usr/sbin/partclone.extfs /usr/sbin/partclone.ext4dev
	use xfs && dosbin partclone.xfs
	use reiserfs && dosbin partclone.reiserfs
	use reiser4 && dosbin partclone.reiser4
	use hfs && dosbin partclone.hfsp
	use fat && (dosbin partclone.fat
				dosym /usr/sbin/partclone.fat /usr/sbin/partclone.fat12
				dosym /usr/sbin/partclone.fat /usr/sbin/partclone.fat16
				dosym /usr/sbin/partclone.fat /usr/sbin/partclone.fat32)
	use ntfs && dosbin partclone.ntfs
	use ntfs && (dosbin partclone.ntfsfixboot
				 dosym /usr/sbin/partclone.ntfsfixboot /usr/sbin/partclone.ntfsreloc)
	use btrfs && dosbin partclone.btrfs
	use f2fs && dosbin partclone.f2fs
	use nilfs2 && dosbin partclone.nilfs2
	use ufs && dosbin partclone.ufs
	use vmfs && dosbin partclone.vmfs partclone.vmfs5
}
