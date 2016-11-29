# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header $

inherit eutils java-pkg-2

MY_PN="xdman"

DESCRIPTION="Xtreme Download Manager uses sophisticated dynamic segmentation algorithm,data compression and connection reuse to speed up the download proces."
SRC_URI="http://sourceforge.net/projects/${MY_PN}/files/${MY_PN}.zip"
HOMEPAGE="http://xdman.sourceforge.net/index.html"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=virtual/jre-1.4"
DEPEND=">=virtual/jdk-1.4
	  app-arch/unzip"

S="${WORKDIR}"

JAVA_SRC_DIR="${S}"

src_install() {
       cd "${S}"
       
       java-pkg_dojar "xdm.jar"
       java-pkg_dolauncher ${PN}
       #dobin  "${PN}.sh"
       #mv ${D}/usr/bin/${PN}.sh ${D}/usr/bin/${PN}
       #dodir /usr/share/${PN}
       #cp "${PN}.jar" ${D}/usr/share/${PN}
       #doins -r "${PN}.jar"
       newicon icon.png "${PN}.png"
       make_desktop_entry ${PN} ${PN} ${PN} Network
}
