# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python2_7 )

EGIT_REPO_URI="git://github.com/bup/${PN}.git
	http://github.com/bup/${PN}.git"
inherit git-2 eutils python-single-r1

DESCRIPTION="It backs things up based on the git packfile format"
HOMEPAGE="http://github.com/bup/bup"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS=""
IUSE="+doc test web"

DEPEND="${PYTHON_DEPS}
		app-arch/par2cmdline
	    dev-python/fuse-python[${PYTHON_USEDEP}]
	    dev-python/pylibacl[${PYTHON_USEDEP}]
	    dev-python/pyxattr[${PYTHON_USEDEP}]
	    web? ( www-servers/tornado[${PYTHON_USEDEP}] )
	    sys-libs/readline:0
	    dev-vcs/git"
RDEPEND="${DEPEND}
         test? (
				dev-lang/perl
				net-misc/rsync
	      ) 
	      doc? ( app-text/pandoc )
"
# unresolved sandbox issues
RESTRICT="test"
src_prepare() {
	default

	sed -e "/^CFLAGS :=/s/-O2 -Werror//" \
		-i Makefile || die
}

src_configure() {
	# only build/install docs if enabled
	export PANDOC=$(usex doc pandoc "")

	./configure || die
}

src_test() {
	emake test
}

src_install() {
	emake DESTDIR="${D}" PREFIX=/usr LIBDIR="/usr/$(get_libdir)/bup" DOCDIR="/usr/share/${PF}" install
	python_fix_shebang "${ED}"
	python_optimize "${ED}"
}
