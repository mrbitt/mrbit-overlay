# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils cmake-utils kde4-base qt4-r2

DESCRIPTION="Folder synchronization and backup tool"
HOMEPAGE="http://opendesktop.org/content/show.php/KFolderSync?content=164092"
#SRC_URI="http://sourceforge.net/projects/kfoldersync/files/${P}.tar.xz"
SRC_URI="http://opendesktop.org/CONTENT/content-files/164092-${PN}_${PV}.orig.tar.xz"

LICENSE="GPL"
SLOT="4"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-qt/qtcore:4
	>=kde-base/kdelibs-4.4:4[aqua=]"

RDEPEND="${DEPEND}"
S=${WORKDIR}/${P}

src_configure() {
	
	if [[ $(gcc-major-version) -lt 4 ]]; then
		append-cxxflags -fno-stack-protector
	fi
	 
	 append-cxxflags -std=gnu++11
	 kde4-base_src_configure  
}

src_install() {
    cd "${S}"
    kde4-base_src_install
}
