# Copyright 1999-2013 Gentoo Foundation 
# Distributed under the terms of the GNU General Public License v2 
# $Header: $ 

EAPI=5

inherit eutils qmake-utils gnome2-utils

DESCRIPTION="QCAD is an application for computer aided drafting in two dimensions (2d)" 
HOMEPAGE="http://www.qcad.org" 
SRC_URI="https://github.com/${PN}/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz" 

LICENSE="GPL-3" 
SLOT="0" 
KEYWORDS="~x86 ~amd64" 
IUSE="" 
RESTRICT="mirror" 

DEPEND="media-libs/glu 
        dev-qt/qtcore:5 
        dev-qt/qtgui:5 
        dev-qt/qtopengl:5 
        dev-qt/qtscript:5 
        dev-qt/qtsvg:5 
        dev-qt/qtxmlpatterns:5
        dev-qt/qthelp:5
        dev-qt/qtsql:5
        dev-qt/designer:5
        sys-devel/gcc" 

src_prepare() {
  rm *.tar.gz
  cd qcad-${PV}
  sed -e 's|$${QT_VERSION}|5.5.0|g' \
      -i src/3rdparty/3rdparty.pro # Don't require specific Qt version
}
 src_compile() {
	    eqmake5  ${PN}.pro
	    emake || die
}

src_install() {                                                                                                                                                                                        
        
        # remove project files
		find . \( -name '*.pri' -or -name '.pro' -or -name '*.ts' \) -delete
		find . \( -name 'Makefile' -name '.gitignore' \) -delete
  
        dodir usr/lib/${PN}                                                                                                                                                                
        
        cp -dpR {release/*,examples,fonts,libraries,patterns,plugins,scripts,ts,readme.txt} "${D}/usr/lib/${PN}/" || die "Failed to install support files"                                                                                                                      
        
        dodir usr/bin
        echo -e '#!/bin/sh\nLD_LIBRARY_PATH=${LD_LIBRARY_PATH:+$LD_LIBRARY_PATH:}"/usr/lib/qcad" exec /usr/lib/qcad/qcad-bin "$@"' >"${D}"/usr/bin/qcad

		# qt
	#for sofiles in /usr/lib/qt/plugins/imageformats/*.so
	#	do
	#	ln -sf ${sofiles} ${D}/usr/lib/qcad/plugins/imageformats/${sofiles##/*/}
	#	done
	#for sofiles in /usr/lib/qt/plugins/sqldrivers/*.so
	#	do
	#	ln -sf ${sofiles} ${D}/usr/lib/qcad/plugins/sqldrivers/${sofiles##/*/}
	#	done

        chmod 0755 ${D}/usr/bin/qcad
			                                                                                                                                                                                              
        insinto /usr/share/icons/hicolor/scalable/apps                                                                                                                                                
        doins scripts/qcad_icon.svg                                                                                                                                                                    
        make_desktop_entry ${PN} QCad qcad_icon Office                                                                                                                                                
} 

pkg_preinst() { 
        gnome2_icon_savelist 
} 

pkg_postinst() { 
        gnome2_icon_cache_update 
} 

pkg_postrm() { 
        gnome2_icon_cache_update 
}

