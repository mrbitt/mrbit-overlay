# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib toolchain-funcs

MY_P="separate+-${PV}"
SFNUM="47873"

DESCRIPTION="Gimp CMYK plug-in."
HOMEPAGE="http://cue.yellowmagic.info/softwares/separate.html"
SRC_URI="
	https://osdn.jp/projects/separate-plus/downloads/51630/separate%2B-${PV}-alpha3.zip -> ${P}.zip
	http://download.adobe.com/pub/adobe/iccprofiles/win/AdobeICCProfilesCS4Win_end-user.zip"

LICENSE="GPL-2 Adobe"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="media-gfx/gimp
	virtual/jpeg
	media-libs/lcms
	media-libs/tiff"
DEPEND="${RDEPEND}
	app-arch/unzip"

S=${WORKDIR}/${MY_P}

src_prepare() {
	#epatch "${FILESDIR}"/${PV}-Makefile.patch
	sed -e "s:GENTOOLIBDIR:$(get_libdir):g" -i Makefile || die
	#sed '/LIBS/s/$/ -lm/' -i Makefile || die
	sed -e "s:#USE_LCMS2:USE_LCMS2:g" -i Makefile || die
	sed -e "s:#include "lcms.h":#include "lcms2.h":g" -i lcms_wrapper.h || die
}

src_compile() {
	emake CC="$(tc-getCC)"
}

src_install() {
	emake PREFIX="${D}/usr" install
	insinto /usr/share/color/icc
	doins -r sRGB
	cd "${WORKDIR}/Adobe ICC Profiles (end-user)"
	doins -r CMYK RGB
}
