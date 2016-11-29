#;; This buffer is for notes you don't want to save, and for Lisp evaluation.
#;; If you want to create a file, visit that file with C-x C-f,
#;; then enter the text in that file's own buffer.

EAPI=5
inherit eutils

DESCRIPTION="Partition cloning utilities"
HOMEPAGE="https://sourceforge.net/projects/partclone-utils"
SRC_URI="https://sourceforge.net/projects/partclone-utils/files/partclone-utils-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="sys-block/partclone
"
