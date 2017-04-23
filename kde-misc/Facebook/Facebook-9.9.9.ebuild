# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
PYTHON_COMPAT=( python{2_7,3_4} )

inherit distutils-r1 git-2 eutils kde4-base qt4-r2

EGIT_REPO_URI="https://github.com/anandbose/facebook/"

DESCRIPTION="Facebook notification tool"
HOMEPAGE="http://nzjrs.github.com/facebook-notify/"
SRC_URI=""

LICENSE="GPL"
SLOT="0"

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    dev-qt/qtwebkit:4
    >=kde-framework/kdelibs-4.4:4"
    
S=${WORKDIR}/${PN}-9.9.9

src_unpack() {
	git-2_src_unpack
}

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    #kde4-base_src_configure
    #cmake .
    #make 
    eqmake4 Socializer.pro
    make clean && make QMAKE=qmake-qt4 PREFIX=/usr
    #sed -i "9s|Application;||g" "${S}"/build/hotshots.desktop || die "sed failed"
    #sed -i -e '2d' "${S}"/build/hotshots.desktop || die "sed failed"
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    #emake DESTDIR="${D}" install || die "Install failed!"
    #kde4-base_src_install
    #qt4-r2_src_install
    dodir /usr/bin
    cp "${S}"/Facebook "${D}"/usr/bin
    #doicon "${S}"/${PN}.ico || die "doicon failed"
    make_desktop_entry ${PN} Facebook ${PN} Network
}
