EAPI=5

inherit kde4-base eutils git-2

KDE_MINIMAL="4.10.0"

DESCRIPTION="PonyCountdown widget for KDE Plasma"
HOMEPAGE="https://github.com/a1batross/plasma-widget-ponycountdownplasma/"
EGIT_REPO_URI="https://github.com/a1batross/plasma-widget-ponycountdownplasma.git"

IUSE=""
KEYWORDS="~amd64 ~x86"
LICENSE="WTFPL-2"
SLOT="0"

DEPEND="
	dev-libs/qjson"
RDEPEND="${DEPEND}"




