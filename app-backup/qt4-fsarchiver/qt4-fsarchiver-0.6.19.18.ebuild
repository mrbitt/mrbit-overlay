# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Necrose99 Proxymaintier  Exp $
#ssh-fs & cifs / samba are highly recomened for network backups and LIVE rescue type disk/s
EAPI=5

inherit qt4-r2 eutils versionator qmake-utils #qt4-build qt5-build unknow test case,

MY_P="${PN}-$(replace_version_separator 3 '-')"
MIN_PV="$(get_version_component_range 1-3)"

DESCRIPTION="Qt4 frontend for fsarchiver"
HOMEPAGE="http://qt4-fsarchiver.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/source/${MY_P}.tar.gz
https://github.com/necrose99/qt4-fsarchiver/raw/master/SRC-TARBALLS/${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE=""

CDEPEND="app-arch/bzip2
	app-arch/xz-utils
	dev-libs/libgcrypt:=
	dev-libs/lzo
	dev-qt/qtcore:4
	dev-qt/qtgui:4
	sys-apps/util-linux
	sys-fs/e2fsprogs
	sys-libs/zlib"
RDEPEND="${CDEPEND}
	>=app-backup/fsarchiver-${MIN_PV}[lzma,lzo]"
DEPEND="${CDEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
     unpack ${MY_P}.tar.gz
}

src_prepare() {
#epatch test on pro / Desktop files
#epatch "${DISTDIR}"/Gentoo-qt4-fsarchiver-pro.diff
#epatch "${DISTDIR}"starter/Gentoo-qt4-fsarchiver-pro.diff
# fix .desktop file ~I dont sed well yet for all 3 desktop files,
sed -i -e '/Encoding/d' starter/*.desktop || die "sed on qt4-fsarchiver.desktop failed"
	# fix .desktop file
	sed -e '/Encoding/d' -i starter/*.desktop || die
	# fix icon installation location
	sed -i \
		-e "/icon.path/s:app-install/icons:${PN}:" "${PN}.pro" \
	|| die "sed on ${PN}.pro failed"
}	
src_configure() {
	qmake ${PN}.pro
}
src_install() {
	emake INSTALL_ROOT="${D}" install
	einstalldocs
}

pkg_postinst() {
	elog "optional dependencies:"
	elog "  sys-fs/btrfs-progs"
	elog "  sys-fs/jfsutils"
	elog "  sys-fs/ntfs3g[ntfsprogs]"
	elog "  sys-fs/reiser4progs"
	elog "  sys-fs/reiserfsprogs"
	elog "  sys-fs/sshfs-fuse"
	elog "  sys-fs/xfsprogs"
}
