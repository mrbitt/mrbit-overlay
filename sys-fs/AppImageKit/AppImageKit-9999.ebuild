# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://github.com/probonopd/AppImageKit.git"
EGIT_MASTER="appimagetool/master"

inherit git-2 multilib

DESCRIPTION="Package desktop applications as AppImages that run on common Linux-based operating systems"
HOMEPAGE="https://github.com/probonopd/AppImageKit"

KEYWORDS="~amd64 ~x86"
SLOT="0"
LICENSE="MIT"
IUSE="systemd"

RDEPEND="sys-fs/fuse
		 sys-libs/glibc
         sys-apps/coreutils
         sys-fs/inotify-tools
         sys-devel/binutils
         dev-libs/openssl
         sys-fs/inotify-tools
         app-arch/lzlib
         net-misc/zsync
         app-arch/xz-utils
         app-arch/lz4
         app-arch/libarchive
         sys-fs/squashfs-tools
         media-libs/libpng "

DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}


src_configure() {
     #cmake . && make clean && make
     sh -ex ./build.sh -s
}

src_install() {
  cd ${S}
  insinto /usr/bin
  doins build/appimaged build/appimagetool build/AppRun build/validate
  chmod 755 "${D}"/usr/bin/* || die
    
  insinto /usr/share/appimage
  doins resources/AppRun README.md
  insinto /usr/share/pixmaps
  doins resources/appimagetool.svg
  #doicon -s 128 resources/appimagetool.svg
  insinto /usr/share/applications
  doins resources/*.desktop
}
