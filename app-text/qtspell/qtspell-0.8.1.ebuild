EAPI=5
inherit cmake-utils

DESCRIPTION="Spell checking for Qt text widgets"
HOMEPAGE="https://github.com/manisandro/qtspell"
SRC_URI="https://github.com/manisandro/${PN}/releases/download/${PV}/${P}.tar.xz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="
        dev-qt/qtcore:4=
		dev-qt/qtgui:4=
	    app-text/enchant
        app-text/iso-codes"

DEPEND="${RDEPEND}"

