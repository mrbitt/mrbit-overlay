# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils kde4-base qt4-r2

DESCRIPTION="Source code text editor"
HOMEPAGE="http://opendesktop.org/content/show.php/KKEdit?content=158161"
SRC_URI="https://dl.dropboxusercontent.com/s/0a3kt510rjei0iw/${P}.tar.gz
	 https://dl.dropboxusercontent.com/s/344hrbutzcco71j/FileBrowser.tar.gz
	 https://dl.dropboxusercontent.com/s/1egcgg5g4u943nn/newproject.tar.gz
	 https://dl.dropboxusercontent.com/s/k6vtn6vgq8zg67l/RemoteEdit.tar.gz
	 https://dl.dropboxusercontent.com/s/34grjyh05cd6b0e/TerminalPane.tar.gz
	 https://dl.dropboxusercontent.com/s/r9cgqrrqmd7llxv/example-plugin.tar.gz
	 https://dl.dropboxusercontent.com/s/1znmykko4h9a83f/SessionManager.tar.gz
	 https://dl.dropboxusercontent.com/s/ho2ct1ae98gsqzi/ClipboardPlugin.tar.gz
	 https://dl.dropboxusercontent.com/s/az4o4p6qrg09h38/OpenUri.tar.gz"
#SRC_URI="http://keithhedger.hostingsiteforfree.com/zips/${PN}/KKEdit-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:4
	>=kde-base/kdelibs-4.4:4[aqua=]"

RDEPEND="${DEPEND}
	app-text/aspell
	dev-util/ctags
	x11-libs/gtksourceview
	dev-libs/libunique
	net-libs/webkit-gtk:2
	x11-misc/xdg-utils
	app-doc/doxygen
	"
S=${WORKDIR}/KKEdit-${PV}

#src_prepare() {
#	cd "${S}"
#	qt4-r2_src_prepare 
#}

src_configure() {
	econf \
		--enable-docviewer --enable-aspell
	cd .. && cd FileBrowser && make
	cd .. && cd example-plugin && make
	cd .. && cd newproject && make
	cd .. && cd RemoteEdit && make
	cd .. && cd TerminalPane && make
	cd .. && cd SessionManager && make
	cd .. && cd ClipboardPlugin && make
	cd .. && cd OpenUri && make
}

src_install() {
    cd "${S}"
    qt4-r2_src_install
    cd .. && cd FileBrowser && mkdir -vp "${D}"/usr/share/KKEdit/plugins/filebrowser && cp -rv libfilebrowser.so "${D}"/usr/share/KKEdit/plugins/filebrowser
    cd .. && cd example-plugin && mkdir -vp "${D}"/usr/lib && cp libkkedit-example-plug.so "${D}"/usr/lib
    cd .. && cd newproject && mkdir -vp "${D}"/usr/share/KKEdit/plugins/newproject && cp -rv libnewproject.so bones "${D}"/usr/share/KKEdit/plugins/newproject
    cd .. && cd RemoteEdit && mkdir -vp "${D}"/usr/share/KKEdit/plugins/remoteedit && cp libremoteedit.so "${D}"/usr/share/KKEdit/plugins/remoteedit
    cd .. && cd TerminalPane && mkdir -vp "${D}"/usr/share/KKEdit/plugins/terminalpane && cp libterminalpane.so "${D}"/usr/share/KKEdit/plugins/terminalpane
    cd .. && cd SessionManager && mkdir -vp "${D}"/usr/share/KKEdit/plugins/sessionmanager && cp libsessionmanager.so "${D}"/usr/share/KKEdit/plugins/sessionmanager
    cd .. && cd ClipboardPlugin && mkdir -vp "${D}"/usr/share/KKEdit/plugins/clipboardplugin && cp libclipboardplugin.so "${D}"/usr/share/KKEdit/plugins/clipboardplugin
    cd .. && cd OpenUri  && cp libopenuri.so "${D}"/usr/share/KKEdit/plugins
}


pkg_postinst() {
		ewarn "Attention if first re-emerge pachage for installl the plugins"
		ewarn ""
}
