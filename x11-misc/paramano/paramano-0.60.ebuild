# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

DESCRIPTION="Docking battery monitor and CPU governer controller (fork of trayfreq)"
HOMEPAGE="https://github.com/phillid/paramano"
SRC_URI="http://phillid.tk/source/${P}-1.tar.gz"

LICENSE="GPL"
SLOT="0"


inherit eutils

KEYWORDS="~amd64"

RDEPEND="x11-libs/gtk+
	  app-admin/sudo"
DEPEND="${RDEPEND}"
    
S=${WORKDIR}/${PN}-stable


