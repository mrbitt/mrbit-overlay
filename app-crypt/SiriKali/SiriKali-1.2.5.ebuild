# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit  versionator

MY_P="$(replace_version_separator 1 '.')"
DESCRIPTION="A Qt/C++ GUI front end to cryfs,gocryptfs,securefs and encfs"
HOMEPAGE="github.com/mhogomchungu/sirikali"
SRC_URI="https://github.com/mhogomchungu/sirikali/releases/download/${MY_P}/${P}.tar.xz"

LICENSE="GPL-v2"
SLOT="0"
IUSE="qt4 +qt5"

inherit eutils cmake-utils

KEYWORDS="amd64 x86"

RDEPEND="
       qt4? ( dev-qt/qtcore:4
			 dev-qt/qtgui:4
			 dev-qt/qtxmlpatterns
			 dev-qt/qt3support:4 )
		
		qt5? ( dev-qt/qtcore:5
			 dev-qt/qtgui:5
			 dev-qt/qtnetwork:5
			dev-qt/qtwidgets:5
			 dev-qt/qtxml:5 ) "
DEPEND="${RDEPEND}
        dev-libs/libgcrypt
        sys-fs/encfs
        app-admin/chrpath
        app-crypt/libsecret
        app-arch/bzip2 "

src_configure() {
     if use qt4 ; then
           mycmakeargs=(
		$(cmake-utils_use_with qt4)
		-DCMAKE_INSTALL_PREFIX=/usr -DQT4=true -DQT5=false
		-DCMAKE_BUILD_TYPE=RELEASE  
		-DNOSECRETSUPPORT=false
	    -DNOKDESUPPORT=true  )
	else
	    mycmakeargs=(
		$(cmake-utils_use_with qt5)
		-DCMAKE_INSTALL_PREFIX=/usr -DQT5=true -DQT4=false
		-DCMAKE_BUILD_TYPE=RELEASE  
		-DNOSECRETSUPPORT=false
	    -DNOKDESUPPORT=true  )
	fi
	cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
}




S=${WORKDIR}/${P}
