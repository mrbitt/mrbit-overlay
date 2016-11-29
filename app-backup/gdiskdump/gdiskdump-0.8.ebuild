# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils

DESCRIPTION="Graphical Front-End for dd (diskdump) of PyGTK applications
             Tool to dump (clone/image) Files, Disks, Partitions with the dd Command"
HOMEPAGE="https://launchpad.net/gdiskdump"
SRC_URI="https://launchpad.net/${PN}/trunk/${PV}/+download/${P}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ppc64 x86"
IUSE=""

RDEPEND="dev-python/pygtk
        dev-python/pygobject
        dev-python/pyinotify
        dev-python/pygtk"
        
DEPEND="${RDEPEND}
    gnome-extra/yelp
    x11-libs/gksu"




