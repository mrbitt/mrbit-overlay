# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="is an application that fetches and parses your html source and generates the graph based on the relationships between different html tags"
HOMEPAGE="http://opendesktop.org/content/show.php/html+viewer?content=118261"
SRC_URI="https://dl.opendesktop.org/api/files/downloadfile/id/1466641193/s/a416c4861685c47396a4df97548bca01/t/1527939422/u/152584/118261-html-view%200.1.rar"

LICENSE="LGPL"
SLOT="0"

inherit eutils qt4-r2

KEYWORDS="amd64 ~mips x86"

RDEPEND=">=kde-frameworks/oxygen-icons-4.13:4"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    dev-qt/qtwebkit
    >=kde-base/kdelibs-4.4:4"
    
S=${WORKDIR}

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    #kde4-base_src_configure
    #cmake .
    #make 
    eqmake4 elasticnodes.pro
    #make clean && make QMAKE=qmake-qt4 PREFIX=/usr
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
    cp "${S}"/elasticnodes "${D}"/usr/bin
}
