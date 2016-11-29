# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit eutils distutils git-2 versionator qt4-r2

DESCRIPTION="QT application based on crossplatform library for playing different chiptune modules"
HOMEPAGE="http://zxtune.bitbucket.org"
SRC_URI=""
LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:4
	>=dev-lib/boost-1.49
	app-arch/zip
	sys-libs/zlib
	net-misc/curl
	media-libs/flac
	media-libs/libvorbis
	media-sound/lame
	media-libs/alsa-lib"
RDEPEND="${DEPEND} >=sys-devel/gcc-4.8"

EGIT_REPO_URI="https://bitbucket.org/zxtune/zxtune.git"
#EGIT_BOOTSTRAP="make -f makefile.mak"
#ESVN_REPO_URI="http://zxtune.googlecode.com/svn/tags/ver3"
#ESVN_BOOTSTRAP="make -f Makefile.svn"
S=${WORKDIR}/${P}
qt4_options="qt.includes=/usr/include/qt4 tools.uic=uic tools.moc=moc tools.rcc=rcc"

src_unpack() {
	if [[ ${PV} == "9999" ]] ; then
		git-2_src_unpack
	else
		unpack ${A}
	fi
	cd "${S}"
}

src_prepare() {
	sed -i '27s|$(qt.dir)/lib|qmake -query QT_INSTALL_LIBS|g' "${S}"/make/qt.mak || die "sed failed"
	sed -i '26s|$(qt.dir)/include|qmake -query QT_INSTALL_HEADERS|g' "${S}"/make/qt.mak || die "sed failed"
}

src_compile() {
        make platform=linux system.zlib=1 release=1 ${qt4_options} -C apps/bundle || die "emake failed"
}

src_install() {
	#emake DESTDIR="${D}" install || die "emake install failed"
	make DESTDIR="${D}" platform=linux release=1 install_linux -C apps/bundle || die "emake install failed"
	dodoc README ChangeLog AUTHORS
}
