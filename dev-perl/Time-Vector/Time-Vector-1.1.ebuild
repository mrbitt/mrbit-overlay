# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MODULE_AUTHOR=ZUMMO
#MODULE_SECTION=modules
MODULE_VERSION=${PV}
inherit perl-module

DESCRIPTION="A Date/Time Parsing Perl Module"

LICENSE="Time-modules public-domain"
SLOT="0"
KEYWORDS="amd64 ~ppc ~ppc64 ~x86"
IUSE=""

SRC_TEST="do"
