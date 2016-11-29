# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
MODULE_AUTHOR=CLINTDW
MODULE_VERSION=0.03
inherit perl-module

DESCRIPTION="Implements the tiger hash, which returns a 192-bit hash value"

IUSE="test"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PERL_RM_FILES=(
	t/02-pod.t
)
RDEPEND="
	virtual/perl-Digest"
DEPEND=""
