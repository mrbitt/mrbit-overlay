# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="is yet another KDE application that uses gmail atom feed to report if a user has new email in their gmail accounts"
HOMEPAGE="http://mhogomchungu.github.io/qCheckGMail/"
SRC_URI="https://github.com/mhogomchungu/qCheckGMail/archive/${PV}.tar.gz -> {P}.tar.gz"

LICENSE="GPL"
SLOT="0"

inherit eutils kde4-base qt4-r2

KEYWORDS="amd64 x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4[aqua=]"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    >=kde-base/kdelibs-4.4:4[aqua=]"
    
S=${WORKDIR}/qCheckGMail-${PV}
#RESTRICT="strip"

src_prepare() {
	cmake-utils_src_prepare

	# install docs into standard Gentoo location
#	sed -i -e "/DESTINATION share/ s:\${CMAKE_PROJECT_NAME}:doc/${PF}:" \
#		CMakeLists.txt || die
}

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    kde4-base_src_configure
    #cmake .
    #make 
    #eqmake4 ${PN}.pro
    #make clean && make QMAKE=qmake-qt4 PREFIX=/usr
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    #emake DESTDIR="${D}" install || die "Install failed!"
    kde4-base_src_install
    #qt4-r2_src_install
    #dodir /usr/local/bin
    #cp "${S}"/build/hotshots "${D}"/usr/local/bin
#	mkdir -p "${D}"/usr/{bin,share/{pixmaps,applications}}
#	cp release/${PN} "${D}"/usr/bin
#	cp Resources/logo.png "${D}"/usr/share/pixmaps
#	make_desktop_entry ${PN} ${PN} ${PN} "/usr/share/pixmaps/logo.png"
}
