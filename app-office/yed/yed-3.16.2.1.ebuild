EAPI="2"

inherit eutils java-pkg-2

DESCRIPTION="Diagram editor written in Java"
HOMEPAGE="www.yworks.com/products/yed/"
SRC_URI="https://www.yworks.com/resources/yed/demo/yEd-${PV}.zip"

LICENSE="yed"
SLOT="0"
KEYWORDS="~x86 ~sparc ~ppc ~amd64 ~ppc64"
IUSE=""
#RESTRICT="fetch"

RDEPEND=">=virtual/jre-1.8
        ${COMMON_DEP}"

DEPEND=">=virtual/jdk-1.8
        ${COMMON_DEP}"

S=${WORKDIR}/${P}

src_install() {
        cd "${S}"
	java-pkg_dojar ${PN}.jar lib/vectorgraphics.jar
    
    java-pkg_dolauncher ${PN} -into "/usr" --jar "${PN}.jar"

        doicon "${S}"/icons/yicon32.png
        make_desktop_entry yed yEd yicon32 "Graphics;2DGraphics"
}

