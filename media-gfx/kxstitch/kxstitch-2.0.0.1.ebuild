# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-gfx/kxstitch/kxstitch-1.2.0.ebuild,v 1.1 2014/08/26 09:57:08 kensington Exp $

EAPI=6

KDE_DOC_DIRS="doc-translations/%lingua_${PN}"
KDE_HANDBOOK="optional"
KDE_LINGUAS="ca cs da de en_GB es et fr hu it lt nl pl pt pt_BR sk sv uk"
inherit kde5

DESCRIPTION="Program to create cross stitch patterns"
HOMEPAGE="http://userbase.kde.org/KXStitch"
SRC_URI="https://github.com/KDE/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz" 

LICENSE="GPL-2"
SLOT="4"
KEYWORDS="amd64"
IUSE="debug"

RDEPEND="
	media-gfx/imagemagick[cxx]
	x11-libs/libX11
"
DEPEND="${RDEPEND}
	sys-devel/gettext
"

	
src_install() {
    cd "${S}_build"
    emake DESTDIR="${D}" install || die "Install failed!"
}
