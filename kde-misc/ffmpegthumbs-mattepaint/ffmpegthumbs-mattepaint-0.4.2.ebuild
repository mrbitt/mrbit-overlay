# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI="5"

PLOCALES="ru"
inherit cmake-utils

DESCRIPTION="Is an alternative version of the standard KDE ffmpegthumbs..."
HOMEPAGE="http://kde-apps.org/content/show.php/FFMpegThumbs-MattePaint?content=153902&PHPSESSID=680b89a1def433333e634da64102cc64"
SRC_URI="http://kde-apps.org/CONTENT/content-files/153902-${PN}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+qt5 -qt4"

if use qt5; then 
     S="${WORKDIR}/${PN}/KF5/${PN}/"
     DEPEND="dev-qt/qtcore:5"
else
    inherit cmake-utils kde4-base
    S="${WORKDIR}/${PN}/KDE4/${PN}/"
    DEPEND="dev-qt/qtcore:4"
fi

RDEPEND="dev-libs/qjson
	     virtual/ffmpeg"

src_configure(){

if use qt4 ; then
          export QT_SELECT=qt4
else
	  export QT_SELECT=qt5  
fi
   cmake-utils_src_configure
}
