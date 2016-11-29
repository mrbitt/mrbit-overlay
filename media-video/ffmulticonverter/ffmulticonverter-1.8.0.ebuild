# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:  $
# Nonofficial ebuild by mrbit --> giacomogiorgianni@gmail.com

EAPI=5
#PYTHON_DEPEND="3"
PYTHON_COMPAT=( python{3_3,3_4,3_5} )

inherit eutils distutils-r1

DESCRIPTION="FF Multi Converter is a GUI application that converts multiple file formats to different extensions"
HOMEPAGE="https://sites.google.com/site/ffmulticonverter/"
SRC_URI="https://sourceforge.net/projects/ffmulticonv/files/${P}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/python-poppler-qt4[${PYTHON_USEDEP}]
	>=dev-python/PyQt4-4.8
	app-office/unoconv
	media-gfx/imagemagick
	media-video/ffmpeg"
DEPEND="${RDEPEND}"

S=${WORKDIR}/${P}

src_prepare() {
        sed -i -e 's:+ vcodecs:+ [vcodecs]:' ffmulticonverter/audiovideotab.py || die
        sed -i -e 's:+ acodecs:+ [acodecs]:' ffmulticonverter/audiovideotab.py || die
}
        
pkg_postinst() {
	elog
	elog "It is recommended to change your make.conf"
	elog "add es. PYTHON_TARGETS="python2_7 python3_4" "
	elog "or USE="python_targets_python3_4" emerge -pv ffmulticonverter"
	elog "or add package.use/custom >=media-video/ffmulticonverter-1.6.0 python_targets_python3_4"
}
 
