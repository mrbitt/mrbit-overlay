# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/ansicolor/ansicolor-0.2.1.ebuild,v 1.1 2014/03/10 07:26:39 jlec Exp $

EAPI=5

PYTHON_COMPAT=( python{3_2,3_3} pypy2_0 )

inherit distutils-r1

DESCRIPTION="Produce ansi color output and colored highlighting and diffing"
HOMEPAGE="https://github.com/tarball69/tkRAD"
SRC_URI="https://pypi.python.org/packages/source/t/${PN}/${P}-Tasmania-Sunset.tar.gz"

SLOT="0"
LICENSE="LGPL v3"
KEYWORDS="~amd64 ~x86 ~amd64-linux ~x86-linux"
IUSE=""

S=${WORKDIR}/${P}-Tasmania-Sunset
