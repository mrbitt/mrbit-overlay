# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit fdo-mime udev unpacker

MY_PN="draftsight"
MY_P="${MY_PN}-${PV}"
DESCRIPTION="Professional 2D CAD application, supporting DWT, DXF and DWG."
HOMEPAGE="http://www.3ds.com/products/draftsight/free-cad-software/"
SRC_URI="${MY_P}.deb"

LICENSE="${MY_PN}"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
S="${WORKDIR}"

QA_PRESTRIPPED="opt/dassault-systemes/${MY_PN}/bin/DWGConverter
	amd64? ( opt/dassault-systemes/${MY_PN}/lib/libaudio.so.2 )"
QA_TEXTRELS="opt/dassault-systemes/${MY_PN}/lib/libDDKERNEL.so.1"
QA_EXECSTACK="opt/dassault-systemes/${MY_PN}/bin/FxCrashRptApp
opt/dassault-systemes/${MY_PN}/lib/libDDKERNEL.so.1"

RESTRICT="fetch"
DEPEND=""
RDEPEND="amd64? (
		sys-libs/zlib
		net-print/cups
		dev-libs/expat
		dev-libs/glib:2
		media-libs/glu
		media-libs/phonon
		dev-qt/qtcore:4
		dev-qt/qtdbus:4
		dev-qt/qtgui:4
		dev-qt/qtopengl:4
		dev-qt/qtsql:4
		dev-qt/qtwebkit:4
		dev-qt/qtsvg:4
		media-libs/alsa-lib
		media-libs/fontconfig
		media-libs/freetype
		x11-libs/libICE
		x11-libs/libSM
		x11-libs/libX11
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXt
		media-libs/nas
		)"

pkg_nofetch() {
	einfo "Upstream has a mandatory EULA agreement to download this file."
	einfo "Please navigate your browser to:"
	einfo "http://www.3ds.com/products-services/draftsight-cad-software/free-download/"
	einfo "Click \"Download DraftSight 2015 for Ubuntu (beta)\""
	einfo "Download the deb file and move it to ${DISTDIR}/${MY_P}.deb"
}

src_install() {
	cp -R "${WORKDIR}/opt" "${D}"
	exeinto /usr/bin
	doexe "${FILESDIR}/${MY_PN}"

	# prepare for dongle
	udev_dorules "${FILESDIR}"/10-ft-rockey.rules
}

pkg_postinst() {
	elog "To use DraftSight as your default viewer for DWG, DXF, and DWT"
	elog "Please run the following commands respectively as your normal user:"
	elog "xdg-mime default \"dassault-systemes\"_\"draftsight.desktop\" \"application/vnd.dassault-systemes.draftsight-dwg\""
	elog "xdg-mime default \"dassault-systemes\"_\"draftsight.desktop\" \"application/vnd.dassault-systemes.draftsight-dxf\""
	elog "xdg-mime default \"dassault-systemes\"_\"draftsight.desktop\" \"application/vnd.dassault-systemes.draftsight-dwt\""

	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	for size in 16 32 48 64 128 ; do
		local XDG_OPTS="--noupdate --novendor --mode system --size ${size}"
		xdg-icon-resource install ${XDG_OPTS} --context apps \
			"${ROOT}/opt/dassault-systemes/DraftSight/Resources/pixmaps/${size}x${size}/program.png" \
			"dassault-systemes.draftsight"
		xdg-icon-resource install ${XDG_OPTS} --context apps --theme gnome \
			"${ROOT}/opt/dassault-systemes/DraftSight/Resources/pixmaps/${size}x${size}/program.png" \
			"dassault-systemes.draftsight"
		for mimetype in dwg dxf dwt ; do
			xdg-icon-resource install ${XDG_OPTS} --context mimetypes \
				"${ROOT}/opt/dassault-systemes/DraftSight/Resources/pixmaps/${size}x${size}/file-${mimetype}.png" \
				"application-vnd.dassault-systemes.draftsight-${mimetype}"
			xdg-icon-resource install ${XDG_OPTS} --context mimetypes --theme gnome \
				"${ROOT}/opt/dassault-systemes/DraftSight/Resources/pixmaps/${size}x${size}/file-${mimetype}.png" \
				"application-vnd.dassault-systemes.draftsight-${mimetype}"
		done
	done
	xdg-icon-resource forceupdate
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	for size in 16 32 48 64 128 ; do
		xdg-icon-resource uninstall --noupdate --context apps --mode system \
			--size ${size} "dassault-systemes.draftsight"
		xdg-icon-resource uninstall --noupdate --context apps --mode system --theme gnome \
			--size ${size} "dassault-systemes.draftsight"
		for mimetype in dwg dxf dwt ; do
			xdg-icon-resource uninstall --noupdate --context mimetypes --mode system \
				--size ${size} "application-vnd.dassault-systemes.draftsight-${mimetype}"
			xdg-icon-resource uninstall --noupdate --context mimetypes --mode system --theme gnome \
				--size ${size} "application-vnd.dassault-systemes.draftsight-${mimetype}"
		done
	done
	xdg-icon-resource forceupdate
}
