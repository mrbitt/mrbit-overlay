# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils multilib 

DESCRIPTION="3D CAD-CAM application that features an integrated 3D OpenGL viewer."
HOMEPAGE="http://opendesktop.org/content/show.php/gCAD3D?content=88766"
SRC_URI="http://www.gcad3d.org/download/${PN}_${PV}-src.zip"
	
LICENSE="GPL-v3"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE="+doc gtk2 +gtk3"

LANGS="en de es fr it"

for lang in ${LANGS}; do
	IUSE+=" linguas_${lang}"
done

DEPEND="virtual/opengl
		virtual/glu
		app-arch/dpkg"
RDEPEND="
		>=dev-libs/glib-2
	gtk2? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
		dev-util/pkgconfig
		dev-util/ctags
		gnome-extra/zenity
		media-libs/libjpeg-turbo
	doc? ( app-doc/doxygen ) "

S=${WORKDIR}/mnt/serv1/Devel/gcad3d/src
S1=${WORKDIR}/mnt/serv1/Devel/
S2=${WORKDIR}
#QA_PREBUILT="usr/lib*/${MY_PN}/*"

#RESTRICT="strip"

src_configure() {
          cd .. 
          mkdir binLinux32 && mkdir binLinux32/plugins
          mkdir binLinux64 && mkdir binLinux64/plugins
          cd "${S}"
        if use gtk3; then
            sed -i "6s|#VGUI|VGUI|g" "${S}"/options.mak || die "sed failed"
            sed -i "5s|VGUI|#VGUI|g" "${S}"/options.mak || die "sed failed" 
        fi
        sed -i "31s|gCAD3D/binLinux|/binLinux|g" "${S}"/options.sh || die "sed failed" 
           #sed -i "75s|vi|nano|g" "${S}"/APP/do || die "sed failed" 
           #sed -i "59s| make|# make |g" "${S}"/APP/do || die "sed failed"  
           #sed -i "63s| make|# make |g" "${S}"/APP/do || die "sed failed"  
           #sed -i "44i\exit;" "${S}"/APP/gcad_gui__.mak || die "sed failed" 
           sed -i "192i\ export gcad_dir_bas=${D}usr/share/gcad3d/" "${S}"/APP/do || die "sed failed"
          #dodir /usr/share/gcad3d 
          export DIR_DEV=${S1}
	cd APP 
	./do help
	./do setup
	./do delete
	./do gui
	#./do Demo_gui1.mak
	#./do guiinit
	#./do c
	#./do allDemos
}

src_install() {
	
	 cd "${S}"
	dodir /usr/$(get_libdir)
	dodir /usr/bin
   
 	if [[ $(get_libdir) == lib32 ]]; then
 	   cd "${S2}"
 	    cp -pPR ../homedir/devel/binLinux32/*.so "${D}"/usr/$(get_libdir) || die "copy failed"
 	    cp -pPR ../homedir/devel/binLinux32/plugins "${D}"/usr/$(get_libdir) || die "copy failed"
 	    cp -pPr ../homedir/devel/binLinux32/gCAD3D "${D}"/usr/$(get_libdir) || die "copy failed"
 	    ln -sf "${D}"/usr/$(get_libdir)/gCAD3D//binLinux32/gCAD3D "${D}"usr/bin || die 
	 else
 	    cd "${S2}"
 	    cp -pPR ../homedir/devel/binLinux64/*.so "${D}"/usr/$(get_libdir) || die "copy failed"
	    cp -pPR ../homedir/devel/binLinux64/plugins "${D}"/usr/$(get_libdir) || die "copy failed"
	    cp -pPR ../homedir/devel/binLinux64/gCAD3D "${D}"/usr/$(get_libdir) || die "copy failed"
	    ln -sf "${D}"usr/$(get_libdir)/gCAD3D "${D}"usr/bin/gcad3d || die "link failed"
     fi 
      dodir /usr/share/{pixmaps,gcad3d}
	  cp -pPR "${S1}"gcad3d/icons ${D}/usr/share/gcad3d/ || die "copy failed"
	  install -D  "${S1}"gcad3d/icons/${PN}.xpm ${D}/usr/share/pixmaps/ || die "copy failed"
	  
	  domenu "${FILESDIR}/${PN}.desktop"  || die "domenu failed"
	  
	if use doc; then
	  dodir /usr/share/doc/gcad3d
	  cd "${S1}"gcad3d/doc
	  cp -pPR "${S1}"gcad3d/doc/{html,msg} "${D}"/usr/share/doc/gcad3d/ || die "copy failed"
	  sed -i "153s|xdg|#xdg|g" gcad_doxygen.sh || die "sed failed" 
	  ./gcad_doxygen.sh || die "doxygen failed"
 	  cp -pPR ./gcad/* "${D}"/usr/share/doc/gcad3d/  || die "copy failed"
   fi
   #for ln in ${LANGS}; do
	#	! use linguas_${ln}
	#	   cp  "${S1}"gcad3d/doc/msg/msg_${ln}.txt "${D}"/usr/share/doc/gcad3d/msg/  || die "copy failed"
	#	   cp  "${S1}"gcad3d/doc/msg/msg_const_${ln}.txt "${D}"/usr/share/doc/gcad3d/msg/  || die "copy failed"
		  #bzip2 -d "${D}"usr/share/gcad3d/doc/msg/msg_${ln}.txt.bz2 || die "unpack failed"
		  #bzip2 -d "${D}"usr/share/gcad3d/doc/msg/msg_const_${ln}.txt.bz2 || die "unpack failed"
	#done
  cd "${S}" 
  #einstalldocs
}
