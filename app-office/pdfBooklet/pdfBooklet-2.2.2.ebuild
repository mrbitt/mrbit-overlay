# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/pyfits/pyfits-3.1.2.ebuild,v 1.2 2013/09/05 18:46:59 mgorny Exp $

EAPI=5

PYTHON_COMPAT=( python{2_6,2_7} )
inherit distutils-r1 eutils toolchain-funcs

DESCRIPTION="It has been extended to many other functions in pdf pages manipulation."
HOMEPAGE="http://pdfbooklet.sourceforge.net/"
SRC_URI="http://sourceforge.net/projects/pdfbooklet/files/pdfBooklet-pdfShuffler%202.2.2/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
"
S=${WORKDIR}/${P}

src_prepare() {
	epatch "${FILESDIR}"/${PN}.patch
	sed -i -e '2d' ${S}/data/pdfbooklet.desktop || die "error" 
}

python_configure_all() {
	tc-export CC
}

python_compile() {
	python_is_python3 || local -x CFLAGS="${CFLAGS} -fno-strict-aliasing -lrt"
	distutils-r1_python_compile
}

python_test() {
	if [[ "${EPYTHON}" == python3* ]]; then
		einfo "Skipping python3 due to many incompatibilities"
	else
		nosetests -svw "${BUILD_DIR}/lib/" || die "Tests fail with ${EPYTHON}"
	fi
}

python_install_all() {
	distutils-r1_python_install_all
}

