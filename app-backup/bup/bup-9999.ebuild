# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

EGIT_REPO_URI="git://github.com/bup/${PN}.git
	http://github.com/bup/${PN}.git"
inherit git-2 eutils python

DESCRIPTION="It backs things up based on the git packfile format"
HOMEPAGE="http://github.com/bup/bup"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+doc"

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
		dev-python/pylibacl
		doc? ( app-text/pandoc )"
RDEPEND="${DEPEND}"

pkg_setup() {
    python_set_active_version 2
	python_pkg_setup
}

src_prepare() {
	epatch_user
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

	dodoc "${D}/usr/share/doc/${PN}"/*
	rm -r "${D}/usr/share/doc/${PN}/" || die

	dodoc README README.md DESIGN
}

src_test() {
	emake test
}
