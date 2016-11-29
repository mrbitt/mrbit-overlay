# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6

inherit cmake-multilib subversion

DESCRIPTION="GPU-based implementation of JPEG2K standard"
HOMEPAGE="http://apps.man.poznan.pl/trac/jpeg2k"
ESVN_REPO_URI="https://apps.man.poznan.pl/svn/jpeg2k/trunk/gpu_jpeg2k"

LICENSE="AGPL-3+"
SLOT="0"
KEYWORDS=""
IUSE=""

DEPEND="dev-util/nvidia-cuda-toolkit"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	cmake-multilib
}
