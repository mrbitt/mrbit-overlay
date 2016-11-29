# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="CL headers from tonyrog, tracked on github."
HOMEPAGE="https://github.com/tonyrog/cl"
EGIT_REPO_URI="git://github.com/tonyrog/cl"
#EGIT_BRANCH="master"

inherit autotools eutils git-2 versionator
SRC_URI=""

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=">=dev-lang/erlang-13.2.1"
DEPEND="${RDEPEND} !dev-util/nvidia-cuda-toolkit"

RESTRICT="mirror"

src_install() {
    local ERL_LIBDIR=/usr/$(get_libdir)/erlang/lib
    #insinto /usr/lib64/erlang/lib/cl/include
    insinto ${ERL_LIBDIR}/cl/include
    for f in src/*; do
        doins $f
    done
    
    for f in include/*; do
        doins $f
    done
}
