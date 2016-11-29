# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

PLOCALES="ru"
inherit cmake-utils

DESCRIPTION="Generates thumbnails from movie posters found on tmdb.org (The Movie DataBase)"
HOMEPAGE="http://kde-apps.org/content/show.php/MovieThumbs?content=157543"
SRC_URI="http://kde-apps.org/CONTENT/content-files/157543-${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-qt/qtcore:4
	dev-libs/qjson"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${P}"

src_prepare() {
	cd "${S}"
	cp core/*.h kde/
	sed -i '28s|<libmoviethumbs/movieclient.h>|"movieclient.h"|g' "${S}"/kde/moviethumbs.h || die "sed failed"
	sed -i '22s|<libmoviethumbs/movieclient.h>|"movieclient.h"|g' "${S}"/kde/moviethumbs.cpp || die "sed failed"
}

src_configure(){
	cd "${S}"
	mkdir "build_core"
	cd build_core
	cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` -DCMAKE_BUILD_TYPE=Release "${S}/core"
	make	
	cd "${S}"
	mkdir "build_kde"
	cd build_kde
	cmake -DCMAKE_INSTALL_PREFIX=`kde4-config --prefix` -DCMAKE_BUILD_TYPE=Release "${S}/kde" -DCMAKE_LIBRARY_PATH=${S}/build_core
	make
}

src_compile() {
	cd "${S}"
}


src_install() {
      cd "${S}"
     cd "${S}"/build_core
      	# Install core components
   emake DESTDIR="${D}" install || die "Install failed!"
  
  # Install MOVIETHUMBS KDE (optional)
        cd "${S}"/build_kde
  emake DESTDIR="${D}" install || die "Install failed!"  
}