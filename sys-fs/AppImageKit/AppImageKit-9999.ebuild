# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://github.com/probonopd/AppImageKit.git"

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
         app-arch/lzlib
         media-libs/libpng "

DEPEND="${RDEPEND}"

S=${WORKDIR}/${PN}


src_configure() {
     cmake . && make clean && make
}

src_install() {
	
  insinto /usr/bin
  doins AppImageAssistant AppImageExtract AppImageMonitor

  insinto /usr/share/appimage
  doins desktopintegration AppRun.c README.md
}
