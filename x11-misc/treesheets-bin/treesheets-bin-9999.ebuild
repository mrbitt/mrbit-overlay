# Distributed under the terms of the GNU General Public License v2

EAPI=6

# functions: domenu, newicon
inherit eutils xdg

DESCRIPTION="Free Form Data Organizer"
HOMEPAGE="http://strlen.com/treesheets/"
LICENSE="ZLIB"

PN_NOBIN="${PN%%-bin}"
SLOT="0"
SRC_URI="http://strlen.com/treesheets/${PN_NOBIN}_linux64.tar.gz"

KEYWORDS="~amd64"
IUSE="+doc +examples"

WX_GTK_VER="3.0"

RDEPEND=">=media-libs/libpng-1.2:1.2
         x11-libs/wxGTK:${WX_GTK_VER}[X]"
DEPEND="${RDEPEND}"

RESTRICT="mirror test"

S="${WORKDIR}/TS"

INST_DIR="/opt/${PN_NOBIN}"

src_prepare() {
	xdg_src_prepare

	sed -r -e "s|(Try)?Exec=|\1Exec=${EPREFIX}${INST_DIR}/|" \
		-i -- "${PN_NOBIN}.desktop" || die
}

src_install() {
	## NOTE: everything must reside in the same dir and with the same structure

	into "${INST_DIR}"

	exeinto "${INST_DIR}"
	doexe "${PN_NOBIN}"
    
    domenu "${PN_NOBIN}.desktop"

	newicon -s 16 images/icon16.png "${PN_NOBIN}"
	newicon -s 32 images/icon32.png "${PN_NOBIN}"
   
    dodir /usr/share/pixmaps
    cp -pPR "${S}"/docs/images/${PN_NOBIN}_logo.png ${D}/usr/share/pixmaps/"${PN_NOBIN}" || die install icon failed
    
	insinto "${INST_DIR}"
	doins -r images

	insinto "${INST_DIR}"
	doins "readme.html"
            
	if use doc ; then
		insinto "${INST_DIR}"
		doins -r docs
	fi

	if use examples ; then
		docinto "${INST_DIR}"
		doins -r examples
	fi
    rm -Rd "${D}"usr/share/doc || die
}
