# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-misc/knutclient/knutclient-0.9_pre1.ebuild,v 1.2 2006/07/27 22:08:42 flameeyes Exp $

EAPI="5"

DESCRIPTION="Client for setting up the NUT UPS monitoring daemon"
HOMEPAGE="http://www.alo.cz/knutsetting/index.html"
SRC_URI="https://code.google.com/p/knut/downloads/knutsetting-0.2.tar.gz"

SLOT="0"
LICENSE="GPL-2"

inherit kde4-base

KEYWORDS="amd64"

RDEPEND=""
DEPEND="${RDEPEND}
	>=kde-base/kdelibs-4.4:4[aqua=]"
MY_P=${P/_/-}
S=${WORKDIR}/${MY_P}

#S=${WORKDIR}/${PN}/${P}

IUSE=""
 
#need-kde 3.1
 
#PATCHES="${FILESDIR}/${P}-gcc41.patch
#         ${FILESDIR}/${P}-cflags.patch"
 
#src_unpack() {
#      kde_src_unpack
 
#      rm -rf "${S}/admin" "${S}/configure"
#      ln -s "${WORKDIR}/admin" "${S}/admin"
#}

src_configure(){
    echo "${WORKDIR}"
    cd "${WORKDIR}/${P}"/build
    #sed -i "9s|httraqt.xpm|httraqt|g" "${S}"/desktop/httraqt.desktop || die "sed failed"
    kde4-base_src_configure
    #cmake -DQT_QMAKE_EXECUTABLE=qmake-qt4 -DCMAKE_INSTALL_PREFIX=/usr ..
}

src_install() {
    cd "${WORKDIR}/${P}"/build 
    echo "${WORKDIR}"
    #chmod 0755 "${WORKDIR}"/httraqt-1.1.0_build/httraqt || die "chmod failed"
    kde4-base_src_install
    #emake BUILD="${S}"/build  DESTDIR="${D}" install
    #dodoc README CHANGES
    rm -fr "${D}"/etc
}