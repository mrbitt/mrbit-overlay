# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/python-poppler-qt4/python-poppler-qt4-0.16.3-r1.ebuild,v 1.1 2013/03/17 17:14:40 floppym Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7} )

inherit eutils distutils-r1 

DESCRIPTION="Is a file manager developed for extra treatments with perform multiple processes to multiple files at once or over and over again the next time."
HOMEPAGE="http://opendesktop.org/content/show.php?action=content&content=124937"
SRC_URI="http://sourceforge.net/projects/hamsimanager/files/${PN}-${PV}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-python/python-poppler-qt4[${PYTHON_USEDEP}]
	>=dev-python/PyQt4-4.8"
DEPEND="${RDEPEND}
	>=dev-python/eyeD3-0.7
	dev-python/cx_Freeze
	dev-python/mysql-python
	dev-python/python-musicbrainz
	dev-python/qscintilla-python"

#pkg_preinst() {
#	mkdir -p ${D}usr/share/applications
#	cp /$WORKDIR/${P}/${PN}.desktop ${D}usr/share/applications/
#	#domenu usr/share/applications/${PN}.desktop
#}
#pkg_setup() {
#	python_set_active_version 2
#	python_pkg_setup
#}
S=${WORKDIR}/${PN}

python_compile() {
	cd "${S}"
	#distutils-r1_python_compile
}

python_install() {
	cd "${S}"
	#distutils-r1_src_install
	#python2 setup.py install --prefix=/usr --root="${D}"/ --optimize=1
	distutils-r1_python_install
	rm -f "${D}/usr/bin/hamsi" || die
	ln -sf "${D}/usr/lib/${PN}-${PV}/hamsi" "${D}/usr/bin/hamsi" || die
}
