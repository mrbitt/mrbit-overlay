# Copyright 2013 Alex Turbov <i.zaufi@gmail.com>
# Distributed under the terms of the GNU General Public License v3

EAPI="5"

EGIT_REPO_URI="https://github.com/zaufi/smart-prompt.git"
inherit cmake-utils

DESCRIPTION="Smart bash prompt: show various context info in a command prompt"
HOMEPAGE="https://github.com/zaufi/smart-prompt"
SRC_URI="http://opendesktop.org/CONTENT/content-files/160498-${P}.tar.gz"

IUSE="git subversion"
LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ppc ~sparc ~x86"

COMMON_DEPEND=">=app-shells/bash-4.0"

DEPEND="${COMMON_DEPEND} dev-util/cmake"
RDEPEND="${COMMON_DEPEND}
    dev-util/dialog"

S=${WORKDIR}/${P}
    
src_configure() {
    local mycmakeargs=(
        $(cmake-utils_use_disable git)
        $(cmake-utils_use_disable subversion SVN)
    )
    cmake-utils_src_configure
}
