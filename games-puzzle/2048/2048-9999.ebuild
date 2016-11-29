# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Join the numbers and get to the 2048 tile!"
HOMEPAGE="http://gabrielecirulli.github.io/2048/"
EGIT_REPO_URI="git://github.com/gabrielecirulli/2048"
#EGIT_BRANCH="master"

inherit autotools eutils git-2 versionator fdo-mime
SRC_URI=""

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-misc/xdg-utils"
DEPEND="${RDEPEND} "

RESTRICT="mirror"

S=${WORKDIR}/${P}

src_install() {
	  
	  dodir /usr/share/{applications,2048}
	  cp -r {js,meta,style} ${D}/usr/share/2048/
	  cp -f {index.html,favicon.ico} ${D}/usr/share/2048/
	  dodoc LICENSE.txt README.md Rakefile
	  make_desktop_entry "xdg-open /usr/share/2048/index.html" "${PN}" "/usr/share/2048/favicon.ico" 
	  mv ${D}/usr/share/applications/*.desktop ${D}/usr/share/applications/${PN}.desktop
}

pkg_postinst() {
	fdo-mime_desktop_database_update
}	
