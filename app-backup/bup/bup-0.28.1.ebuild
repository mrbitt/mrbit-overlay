# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils python

DOC_COMMIT="bc21345a527cc446084369861655126f6b0ecd8a"

DESCRIPTION="It backs things up based on the git packfile format"
HOMEPAGE="http://github.com/bup/bup"
SRC_URI="http://github.com/bup/bup/archive/${PV/_/-}.tar.gz -> ${P}.tar.gz
	http://github.com/bup/bup/archive/${DOC_COMMIT}.tar.gz -> ${P}-man.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64"
IUSE=""

DEPEND="|| (
			dev-lang/python:2.4
			dev-lang/python:2.5
			dev-lang/python:2.6
			dev-lang/python:2.7
		)
		dev-vcs/git
		app-arch/par2cmdline
		dev-python/fuse-python
		dev-python/pyxattr
		dev-python/pylibacl"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${P}

pkg_setup() {
    python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	mv "../bup-${DOC_COMMIT}" bup-man || die
	python_convert_shebangs -r 2 .
}

src_configure() {
	echo "Nothing to configure..."
}

src_compile() {
	emake CFLAGS="${CFLAGS}" LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake install DESTDIR="${D}"

	doman "${S}"/bup-man/*

	#dodoc "${D}/usr/share/doc/${PN}"/*
	#rm -r "${D}/usr/share/doc/${PN}/" || die

	dodoc README README.md DESIGN
}

src_test() {
	emake test
}
