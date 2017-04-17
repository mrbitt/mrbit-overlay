# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

DESCRIPTION="Ascii Design is an ascii-art program based on figlet engine."
HOMEPAGE="https://github.com/Faster3ck/Ascii-Design"
#SRC_URI="https://github.com/elvisangelaccio/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"
#SRC_URI="http://sourceforge.net/projects/${PN}/files/${PN}/Ascii-Design%201.1.1/${P}.tar.bz2 http://ascii-design.sourceforge.net/figlet_fonts.zip"
SRC_URI="https://github.com/Faster3ck/Ascii-Design/archive/v${PV}.tar.gz -> ${P}.tar.gz http://www.jave.de/figlet/figletfonts40.zip"

LICENSE="GPL"
SLOT="0"
IUSE="+figlet"

inherit eutils kde5

KEYWORDS="amd64 x86"

RDEPEND="kde-frameworks/oxygen-icons"
DEPEND="${RDEPEND}
    dev-qt/qtcore:4
    figlet? ( app-misc/figlet )
    >=kde-frameworks/kdelibs-4.14:4"
    
S=${WORKDIR}/Ascii-Design-${PV}
#RESTRICT="strip"

src_prepare() {
	cmake-utils_src_prepare
}

src_configure(){
    echo "${WORKDIR}"
    cd "${S}"
    kde5_src_configure
}

	
src_install() {
    cd "${S}"
    echo "${WORKDIR}"
    kde5_src_install
    mkdir ${D}/usr/share/figlet
    #For collision file.flt of figlet
    if use figlet; then
     rm ${WORKDIR}/fonts/{banner.*,big.*,block.*,bubble.*,digital.*,ivrit.*,lean.*,mini.*,mnemonic.*,script.*,shadow.*,slant.*,small.*,smscript.*,smshadow.*,smslant.*,standard.*,term.*,upper.*}
     cp -pfPR ${WORKDIR}/fonts/* ${D}/usr/share/figlet || die "copying files failed!"
    fi
}
