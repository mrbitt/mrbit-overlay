# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="XnView MP image viewer/converter"
HOMEPAGE="http://www.xnview.com/"
# Upstream tarballs have no version number *sigh*
SRC_URI="amd64? ( http://download.xnview.com/XnViewMP-linux-x64.tgz )
	x86? ( http://download.xnview.com/XnViewMP-linux.tgz )"

SLOT="0"
LICENSE="free-noncomm as-is"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=dev-libs/glib-2
	>=dev-qt/qtgui-4.8.5-r1
        >=media-libs/libpng-1.2.50-r1
        dev-qt/qtsvg
        app-emulation/emul-linux-x86-qtlibs
        media-libs/tiff
	x11-libs/libX11
	x11-libs/libXi
	x11-libs/libXt
	|| ( >=dev-qt/qt-4.3.0:4 ( dev-qt/qtgui:4 ) )"
DEPEND=""

RESTRICT="strip"
S="${WORKDIR}/XnView"

src_install() {
	local XNVIEW_HOME=/opt/XnView
        
	# Install XnView in /opt
	dodir ${XNVIEW_HOME%/*}
	cp -a "${S}" "${D}"${XNVIEW_HOME} \
		|| die "Unable to install XnView folder"

	# Create /opt/bin/xnview
	dodir /opt/bin/
	cat <<EOF >"${D}"/opt/bin/xnview
#!/bin/sh
LD_LIBRARY_PATH=/opt/XnView/lib
export LD_LIBRARY_PATH
QT_PLUGIN_PATH=/opt/XnView/lib
export QT_PLUGIN_PATH
exec /opt/XnView/XnView "\$@"
EOF
	fperms 0755 /opt/bin/xnview
	rm -r ${D}/${XNVIEW_HOME}/lib || die 
	# Install icon and .desktop for menu entry
	newicon "${D}"${XNVIEW_HOME}/xnview.png ${PN}.png
	make_desktop_entry xnview XnviewMP ${PN} "Graphics"
	#dosym /usr/lib/libpng16.so.16 ${XNVIEW_HOME}/lib/imageformats/libpng12.so.0 || die
}
