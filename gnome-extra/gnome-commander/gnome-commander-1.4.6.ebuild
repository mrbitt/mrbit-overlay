# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License, v2 or later
# $Header: $

EAPI=5

PYTHON_DEPEND="2:2.6"

inherit eutils gnome2 autotools

DESCRIPTION="A full featured, twin-panel file manager for Gnome2"
HOMEPAGE="http://gcmd.github.io/"
SRC_URI="http://ftp.gnome.org/pub/GNOME/sources/${PN}/1.4/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="chm doc exif +gsf id3 nls pdf python taglib"

DEPEND="app-text/gnome-doc-utils
        dev-libs/glib:2
        dev-util/intltool
        gnome-base/gnome-vfs
        gnome-base/libgnome
        gnome-base/libgnomeui
        x11-libs/gtk+:2
        chm? ( dev-libs/chmlib )
        doc? ( gnome-extra/yelp )
        exif? ( media-gfx/exiv2 )
        gsf? ( gnome-extra/libgsf )
        pdf? ( app-text/poppler )
        python? ( =dev-lang/python-2* )
        taglib? ( media-libs/taglib ) 
        virtual/pkgconfig"
RDEPEND="${ALL_DEPEND}"

DOCS="AUTHORS BUGS ChangeLog NEWS README TODO"

pkg_setup() {
        G2CONF="$(use_enable doc scrollkeeper )
                $(use_enable python)
                $(use_with chm libchm)
                $(use_with exif exiv2)
                $(use_with gsf libgsf)
                $(use_with taglib)
                $(use_with pdf poppler)"
}
