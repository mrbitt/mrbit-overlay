# Copyright 2004-2013 Sabayon
# Distributed under the terms of the GNU General Public License v2
# $

EAPI=5

inherit eutils multilib 

DESCRIPTION="Is a user interface abstraction layer for C-programs to Gtk2 or Gtk3, 32-bit or 64-bit"
HOMEPAGE="http://opendesktop.org/content/show.php/C-KIT-GUI-GTK?content=163254"
SRC_URI="http://www.gcad3d.org/${P}-Linux.tar.gz"

LICENSE="GPL"
KEYWORDS="~amd64 ~x86"
SLOT="0"
IUSE="gtk2 gtk3"

RDEPEND="${DEPEND}
	>=dev-libs/glib-2
	x11-libs/gtk+:2
	x11-libs/gtk+:3"
DEPEND="${DEPEND}
	virtual/pkgconfig"

DOCS="AUTHORS README"
S=${WORKDIR}

src_configure() {
          cd "${S}/gui"
         if use gtk3; then
           sed -i "5s|#VGUI|VGUI|g" "${S}"/gui/options.mak || die "sed failed" 
         fi
	make -f c-kit-gui-gtk.mak
}

src_install() {
	  dodir /usr/$(get_libdir)
 	  dodir /usr/share/doc/${PN}
 	  cp -pPR "${S}"/gui/devdoc "${D}"/usr/share/doc/${PN}/
 	  
 	if [[ $(get_libdir) == lib32 ]]; then
	    cp -pPR "${S}"/binLinux32/*.so "${D}"/usr/$(get_libdir)
	else
	    cp -pPR "${S}"/binLinux64/*.so "${D}"/usr/$(get_libdir)
	fi    
}
