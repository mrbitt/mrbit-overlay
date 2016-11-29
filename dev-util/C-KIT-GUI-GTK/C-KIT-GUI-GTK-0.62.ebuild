# Copyright 2004-2013 Sabayon
# Distributed under the terms of the GNU General Public License v2
# $

EAPI=5

inherit eutils multilib 

DESCRIPTION="Is a user interface abstraction layer for C-programs to Gtk2 or Gtk3, 32-bit or 64-bit"
HOMEPAGE="http://opendesktop.org/content/show.php/C-KIT-GUI-GTK?content=163254"
#SRC_URI="http://www.gcad3d.org/${P}-Linux.tar.gz"
SRC_URI="http://www.gcad3d.org/ckitgui_V${PV}.zip"
LICENSE="GPL"
KEYWORDS="amd64 ~x86"
SLOT="0"
IUSE="+doc +examples gtk2 +gtk3"

RDEPEND="${DEPEND}
	>=dev-libs/glib-2
	x11-libs/gtk+:2
	x11-libs/gtk+:3"
DEPEND="${DEPEND}
	virtual/pkgconfig
	doc? ( app-doc/doxygen )"
	
DOCS="LICENSE README"
S=${WORKDIR}/ckitgui/src

src_configure() {
          cd .. 
          mkdir binLinux32
          mkdir binLinux64
          cd "${S}"
        if use gtk3; then
            sed -i "5s|#VGUI|VGUI|g" "${S}"/options.mak || die "sed failed" 
         else
          sed -i "4s|#VGUI|VGUI|g" "${S}"/options.mak || die "sed failed" 
          sed -i "5s|VGUI|#VGUI|g" "${S}"/options.mak || die "sed failed" 
        fi
	cd "${S}/APP" && make -f ckitgui.mak
		
}

src_install() {
	  cd "${S}"
	  dodir /usr/$(get_libdir)

 	if [[ $(get_libdir) == lib32 ]]; then
 	    
 	    cp -pPR ../binLinux32/*.so "${D}"/usr/$(get_libdir) || die "copy failed"
	fi
	    cp -pPR ../binLinux64/*.so "${D}"/usr/$(get_libdir) || die "copy failed"
	
	if use doc; then
	  dodir /usr/share/doc/${P}
	  doxygen ../doc/gui_doxygen/Doxyfile || die
	  #../doc/gui_doxygen.sh
 	  cp -pPR ../doc/gui/* "${D}"/usr/share/doc/${P}/  || die "copy failed"
 	fi

    if use examples; then
        cd APP
        make -f hello-world.mak && make -f hello-world.mak >> hello
	    make -f tst_lst1.mak && make -f tst_lst1.mak >> tst_lst1
	    make -f tst_lst2.mak && make -f tst_lst2.mak >> tst_lst2
		make -f tst_ed1.mak && make -f tst_ed1.mak >> tst_ed1
		make -f tst_gui1.mak && make -f tst_gui1.mak >> tst_gui1
		make -f tst_gui2.mak && make -f tst_gui2.mak >> tst_gui2
		cd ..
	fi
	
   cd .. && einstalldocs
}
