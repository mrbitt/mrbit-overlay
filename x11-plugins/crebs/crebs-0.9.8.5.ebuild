# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils gnome2-utils

DESCRIPTION="Is a Python/GTK application Slideshow (https://launchpad.net/crebs) "
HOMEPAGE="http://www.obfuscatepenguin.net/crebs/"
SRC_URI="https://launchpadlibrarian.net/60892008/${P}.tar.gz"

LICENSE="GPLv3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-python/pygtk"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}



src_install() {
   sed -i "s:OnlyShowIn=GNOME::" crebs/share/applications/${PN}.desktop || die
   sed -i "s:DesktopSettings:DesktopSettings;:" crebs/share/applications/${PN}.desktop || die
   sed -i "s:text/xml:text/xml;:" crebs/share/applications/${PN}.desktop || die
   sed -i -e "s|update-desktop-database|#update-desktop-database|g" ${S}/setup.sh || die
     dodir usr || die
     ./setup.sh -p ${D}/usr
     gnome2_icon_cache_update
}