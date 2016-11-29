# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils 

DESCRIPTION="a graphical interface for changing the system date and time"
SRC_URI="https://fedorahosted.org/released/system-config-date/${P}.tar.bz2"
HOMEPAGE="https://fedorahosted.org/released/system-config-date"

LICENSE="LGPL-2.1"
SLOT="1"
KEYWORDS="amd64 ~x86"
IUSE="+systemd"

RDEPEND="dev-python/pygobject:3
	>=dev-python/pygtk-2.16
	sys-auth/polkit
	dev-python/libgnomecanvas-python
	dev-python/python-slip
	"
DEPEND="dev-util/desktop-file-utils"

S=${WORKDIR}/${P}


