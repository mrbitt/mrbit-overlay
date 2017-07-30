# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


EAPI=6

inherit git-r3 
MY_PN="iconpack-obsidian"

DESCRIPTION="Obsidian Icon Theme - Default Color"
HOMEPAGE="https://www.gnome-look.org/p/1169579"
#SRC_URI="https://github.com/madmaxms/${MY_PN}/archive/${git_sha}.tar.gz"
EGIT_REPO_URI="https://github.com/madmaxms/${MY_PN}.git"

if [[ ${PV} == *99999999* ]];then
	KEYWORDS=""
else
	KEYWORDS="~*"
	EGIT_BRANCH="gray"
	EGIT_COMMIT="ce1770f2527843c65db8c4b0c4c3885e6946ab89"
fi

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}"

S="${WORKDIR}/${P}"

src_install() {
	insinto /usr/share/icons/Obsidian_gray
	doins -r * || die
	dodoc README.md LICENSE
	rm -f "${D}"/usr/share/icons/Obsidian_gray/{LICENSE,README.md,logo.jpg} || die
}
