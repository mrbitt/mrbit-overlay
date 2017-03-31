# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit rpm

DESCRIPTION="Additional proprietary codecs for Vivaldi web browser."
HOMEPAGE="http://www.vivaldi.net"

LICENSE="LGPL2.1"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

VIVALDISRCVER="vivaldi"
PKGSRC="${VIVALDISRCVER}-ffmpeg-codecs-${PV}"

# https://build.opensuse.org/package/view_file/home:Juippis/vivaldi-ffmpeg-codecs/vivaldi-ffmpeg-codecs.spec
SRC_URI="
	amd64? ( http://download.opensuse.org/repositories/home:/Juippis/openSUSE_Tumbleweed/x86_64/${PKGSRC}-4.1.x86_64.rpm )"

DEPEND=">=www-client/vivaldi-1.7"
RDEPEND="${DEPEND}"

S=${WORKDIR}

pkg_setup() {
	if [[ -e "${ROOT}opt/vivaldi/vivaldi" ]]; then
		export VIVALDIVER="vivaldi"

	elif [[ -e "${ROOT}opt/vivaldi-snapshot/vivaldi" ]]; then
		export VIVALDIVER="vivaldi-snapshot"
		die || "Vivaldi-snapshot detected. Please install vivaldi-snapshot-ffmpeg-codecs "

	else 
		export VIVALDIVER="" 
		die || "Couldn't locate Vivaldi installation directory."
	fi
}

src_unpack() {
	rpm_src_unpack ${A}
}

src_install() {

	if [[ ${VIVALDIVER} == "" ]]; then
		die || "Is Vivaldi installed?"
	fi 

	cd ${S}
	mkdir -p ${D}/opt/${VIVALDIVER}/
	cp ${S}/opt/${VIVALDISRCVER}/libffmpeg.so ${D}/opt/${VIVALDIVER}/libffmpeg.so
}
