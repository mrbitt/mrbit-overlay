# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="The open source mesh processing system"
HOMEPAGE="http://www.meshlab.net/"
SRC_URI="https://github.com/cnr-isti-vclab/meshlab/archive/v${PV}.tar.gz https://github.com/cnr-isti-vclab/vcglib/archive/v1.0.1.tar.gz"


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""
DEPEND="dev-cpp/eigen:3
	dev-cpp/muParser
	dev-qt/qtcore:5
	dev-qt/qtopengl:5
	dev-qt/qtxmlpatterns:5
	media-libs/glew
	media-libs/qhull
	=media-libs/lib3ds-1*
	media-libs/openctm
	sci-libs/levmar
	sys-libs/libunwind
	sci-libs/mpir"
RDEPEND="${DEPEND}"

S="${WORKDIR}/meshlab-${PV}/src"

eedos2unix() {
 	[[ $# -eq 0 ]] && return 0
	find "$@" -type f -exec sed -i 's/\r$//' -- {} + || die
}


src_prepare() {
    cd "${WORKDIR}"
	eedos2unix "${WORKDIR}"
	#find . -type f -print0 | xargs -0 -n 1 -P 4 dos2unix > /dev/null
	
	#find "${S}" -type f -print0 | xargs -0 dos2unix --
    #find . -type f -exec dos2unix {} \;
	cd "${S}"
    rm -fr external/{inc,lib} || die "remove files failed!"
    epatch "${FILESDIR}/1.3.4/"*.patch || die "patch files failed!"
    
    mv plugins_experimental/io_TXT/io_txt.pro plugins_experimental/io_TXT/io_TXT.pro || die "rename files failed!"
    sed -i "s|vcglib|vcglib-1.0.1|g" general.pri || die "sed failed"
    sed -i "s|vcglib|vcglib-1.0.1|g" meshlabplugins/edit_manipulators/edit_manipulators.pro || die "sed failed"
  #eapply_user	
}

#src_configure() {
	#eqmake5 -recursive external/external.pro
	#eqmake5 -recursive meshlab_full.pro
#}

src_compile() {
	cd external && eqmake5 -recursive external.pro && emake
	cd .. &&  lrelease meshlab_full.pro && eqmake5 -recursive meshlab_full.pro && emake
}

src_install() {
	cd "${S}/distrib"

  # install meshlab
  install -d -m755 ${D}/usr/bin
  install -d -m755 ${D}/usr/lib/meshlab
  install -d -m755 ${D}/usr/share/meshlab
  install -t ${D}/usr/bin meshlab*
  install -t ${D}/usr/lib/meshlab libcommon*

  cp -a plugins  ${D}/usr/lib/meshlab
  cp -a shaders  ${D}/usr/share/meshlab
  cp -a textures ${D}/usr/share/meshlab
  cp -a sample   ${D}/usr/share/meshlab



  # install man pages
  install -d -m755 "${D}/usr/share/man/man1"
  install -m644 "${D}/meshlab/docs/meshlab.1" "${D}"/usr/share/man/man1
  install -m644 "${D}/meshlab/docs/meshlabserver.1" "${D}"/usr/share/man/man1

  # install icons
  install -d -m755 "${D}/usr/share/pixmaps"
  install -m644 "${S}/meshlab/images/eye_cropped.png" "${D}/usr/share/pixmaps/meshlab.png"

  # install desktop entry
  install -d -m755 "${D}/usr/share/applications"
  install -m644 "${FILESDIR}/1.3.4/meshlab.desktop" "${D}/usr/share/applications"
  sed -i "s#Version=.*#Version=${PV}#" "${D}/usr/share/applications/meshlab.desktop"
}

