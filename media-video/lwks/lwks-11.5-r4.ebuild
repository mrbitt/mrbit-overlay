# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit versionator unpacker gnome2-utils

VERSIONS=($(get_all_version_components))
#MAJOR_VERSION="${VERSIONS[0]}.${VERSIONS[2]}"
#MINOR_VERSION="$(echo ${VERSIONS[3]} | tr '[a-z]' '[A-Z]')"
#REV_VERSION=".$(echo ${VERSIONS[5]#*alpha} | tr '[1-9]' '[A-I]')"
#MY_P="${PN}-${MAJOR_VERSION}.${MINOR_VERSION}"
if [ "x${REV_VERSION}" != "x." ]; then
	MY_P="${MY_P}${REV_VERSION}"
fi

DESCRIPTION="LightWorks video editor software"
HOMEPAGE="http://www.lwks.com/"
SRC_URI="${P}-amd64.deb"

RESTRICT="fetch mirror"

LICENSE="as-is"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=""
RDEPEND="
	virtual/opengl
	x11-libs/cairo
	x11-libs/gdk-pixbuf
	x11-libs/gtk+
	gnome-extra/libgsf
	media-libs/libjpeg-turbo
	x11-libs/pango
	media-gfx/nvidia-cg-toolkit
	media-libs/portaudio
	media-libs/tiff
	sys-apps/util-linux
	dev-libs/openssl
	net-misc/curl
	"

S="${WORKDIR}/"

rc_prepare() {
	cd ${S}
	epatch "${FILESDIR}"/desktop.patch || die
	mkdir -p usr/share/icons/hicolor/64x64/apps/
	cp usr/share/lightworks/Icons/App.png usr/share/icons/hicolor/64x64/apps/lightworks.png
}

src_install() {
	cp -R . ${D}

	# There dirs can be changed by the user
	fperms a+rw /usr/share/lightworks/{Preferences,"Audio Mixes"}
	ln -s "/usr/lib/libjpeg.so" "${D}/usr/lib32/libjpeg.so.8" || die error
	rm "${D}/control.tar.gz" "${D}/data.tar.gz" "${D}/debian-binary"	
}

pkg_postinst() { gnome2_icon_cache_update; }
pkg_preinst() { gnome2_icon_savelist; }
pkg_postrm() { gnome2_icon_cache_update; }
