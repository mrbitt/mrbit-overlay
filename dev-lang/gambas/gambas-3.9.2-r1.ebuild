# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit autotools eutils libtool flag-o-matic fdo-mime gnome2-utils xdg

SLOT="3"
MY_PN="${PN}${SLOT}"

DESCRIPTION="Gambas is a free development environment based on a Basic interpreter with object extensions"
HOMEPAGE="http://gambas.sourceforge.net"

SRC_URI="mirror://sourceforge/${PN}/${MY_PN}-${PV}.tar.bz2"
RESTRICT="mirror"

LICENSE="GPL-2"
KEYWORDS="~*"

IUSE="+curl +net +qt4 +x11
	+bzip2 +cairo +crypt +dbus +examples +gmp +gnome +gsl +gstreamer +gtk2 +gtk3 +httpd +image-imlib +image-io -jit +libxml +mime
	+mysql +ncurses +odbc +openal +opengl +openssl +pcre +pdf +pop3 postgres +qt4-opengl +qt5-opengl +qt4-webkit +qt5-webkit +qt5 +sdl +sdl-sound +sdl2 +sqlite +v4l +xml +zlib"

# gambas3 have the only one gui. it is based on qt4.
# these use flags (modules/plugins) require this qt4 gui to be present at the system to work properly:
# cairo gnome gstreamer gtk2 gtk3 imageimlib imageio opengl pdf sdl sdl2 v4l

REQUIRED_USE="cairo? ( qt4 x11 )
	gnome? ( qt4 x11 )
	gstreamer? ( qt4 x11 )
	gtk2? ( qt4 x11 )
	gtk3? ( qt4 x11 )
	image-imlib? ( qt4 x11 )
	image-io? ( qt4 x11 )
	net? ( curl
		pop3? ( mime ) )
	opengl? ( qt4 x11 )
	pdf? ( qt4 x11 )
	qt4? ( x11 )
	qt4-opengl? ( qt4 )
	qt4-webkit? ( qt4 )
	sdl? ( qt4 x11 )
	sdl-sound? ( sdl )
	sdl2? ( qt4 x11 )
	v4l? ( qt4 x11 )"

RDEPEND="bzip2? ( app-arch/bzip2 )
	cairo? ( x11-libs/cairo )
	curl? ( net-misc/curl )
	dbus? ( sys-apps/dbus )
	gnome? ( gnome-base/gnome-keyring )
	gmp? ( dev-libs/gmp )
	gsl? ( sci-libs/gsl )
	gstreamer? ( media-libs/gst-plugins-base
		media-libs/gstreamer )
	gtk2? ( x11-libs/gtk+:2 )
	gtk3? ( x11-libs/gtk+:3 )
	jit? ( sys-devel/llvm )
	image-imlib? ( media-libs/imlib2 )
	image-io? ( dev-libs/glib
		x11-libs/gdk-pixbuf )
	libxml? ( dev-libs/libxml2 )
	mime? ( dev-libs/gmime )
	mysql?  ( virtual/mysql )
	ncurses? ( sys-libs/ncurses )
	odbc? ( dev-db/unixODBC )
	openal? ( media-libs/openal 
		       media-libs/alure )
	opengl? ( media-libs/mesa )
	openssl? ( dev-libs/openssl )
	pcre? ( dev-libs/libpcre )
	pdf? ( app-text/poppler )
	postgres? ( virtual/postgresql-base )
	qt4? ( dev-qt/qtcore:4[qt3support]
		dev-qt/qtgui:4[qt3support]
		dev-qt/qtsvg:4 )
	qt4-opengl? ( dev-qt/qtwebkit:4 )
	qt4-webkit? ( dev-qt/qtopengl:4[qt3support] )
	qt5? (
		>=dev-qt/qtcore-5.4.0:5
		>=dev-qt/qtopengl-5.4.0:5
		>=dev-qt/qtwebkit-5.4.0:5
	)
	sdl? ( media-libs/libsdl[opengl]
		media-libs/sdl-image
		media-libs/sdl-ttf )
	sdl-sound? ( media-libs/sdl-mixer )
	sdl2? ( media-libs/libsdl2
		media-libs/sdl2-image
		media-libs/sdl2-mixer )
	v4l? ( virtual/jpeg:0
		media-libs/libpng )
	x11? ( x11-libs/libX11
		x11-libs/libXtst )
	xml? ( dev-libs/libxml2
		dev-libs/libxslt )
	zlib? ( sys-libs/zlib )"

DEPEND="${RDEPEND}
	virtual/libintl
	virtual/pkgconfig"

S="${WORKDIR}/${MY_PN}-${PV}"

autocrap_cleanup() {
	sed -e "/^\(AC\|GB\)_CONFIG_SUBDIRS(${1}[,)]/d" \
		-i "${S}/configure.ac" || die
	sed -e "/^ \(@${1}_dir@\|${1}\)/d" \
		-i "${S}/Makefile.am" || die
}

src_prepare() {
	xdg_src_prepare
	epatch "${FILESDIR}/${PN}-3.9.x-xdgutils.patch"
	# deprecated
	find . -name "Makefile.am" | xargs \
		sed -r -e 's|^[ \t]*xdg-.*\\|\\|' -i --
	assert
	
	local sedargs=(
		# respect C(XX)FLAGS
		-e '/C(XX)?FLAGS=""/d'
		-e '/CX*FLAGS[_A-Z]*=/ s:(-O[a-z0-9]*|-g[a-z0-9]*|-fno-omit-[a-z-]*)::g'
	)
	sed -r "${sedargs[@]}" -i -- acinclude.m4 || die
	
	autocrap_cleanup sqlite2 
    
    #MAKEOPTS="${MAKEOPTS} -j12"
    
    #if use qt5 ; then
		#epatch "${FILESDIR}/prefer-qt5.patch" || die "patch failed"
	#fi	

	use_if_iuse bzip2 || autocrap_cleanup bzlib2
	use_if_iuse cairo || autocrap_cleanup cairo
	use_if_iuse crypt || autocrap_cleanup crypt
	use_if_iuse curl || autocrap_cleanup curl
	use_if_iuse dbus || autocrap_cleanup dbus
	use_if_iuse examples || autocrap_cleanup examples
	use_if_iuse gsl || autocrap_cleanup gsl
	use_if_iuse gmp || autocrap_cleanup gmp
	use_if_iuse gnome || autocrap_cleanup keyring
	use_if_iuse gstreamer || autocrap_cleanup media
	use_if_iuse gtk2 || autocrap_cleanup gtk
	use_if_iuse gtk3 || autocrap_cleanup gtk3
	use_if_iuse httpd || autocrap_cleanup httpd
	use_if_iuse image-imlib || autocrap_cleanup imageimlib
	use_if_iuse image-io || autocrap_cleanup imageio
	use_if_iuse jit || autocrap_cleanup jit
	use_if_iuse libxml || autocrap_cleanup libxml
	use_if_iuse mime || autocrap_cleanup mime
	use_if_iuse mysql || autocrap_cleanup mysql
	use_if_iuse ncurses || autocrap_cleanup ncurses
	use_if_iuse net || autocrap_cleanup net
	use_if_iuse odbc || autocrap_cleanup odbc
	use_if_iuse openal || autocrap_cleanup openal
	use_if_iuse opengl || autocrap_cleanup opengl
	use_if_iuse openssl || autocrap_cleanup openssl
	use_if_iuse pcre || autocrap_cleanup pcre
	use_if_iuse pdf || autocrap_cleanup pdf
	use_if_iuse postgres || autocrap_cleanup postgresql
	use_if_iuse qt4 || autocrap_cleanup qt4
	use_if_iuse qt5 || autocrap_cleanup qt5
	use_if_iuse sdl || autocrap_cleanup sdl
	use_if_iuse sdl-sound || autocrap_cleanup sdlsound
	use_if_iuse sdl2 || autocrap_cleanup sdl2
	use_if_iuse sqlite || autocrap_cleanup sqlite
	use_if_iuse v4l || autocrap_cleanup v4l
	use_if_iuse x11 || autocrap_cleanup x11
	use_if_iuse xml || autocrap_cleanup xml
	use_if_iuse zlib || autocrap_cleanup zlib

	eautoreconf
	#eapply_user
	#./reconf-all
}

src_configure() {
	
	append-cxxflags -std=gnu++11

	#if [[ $(gcc-major-version) -lt 4 ]]; then
		#append-cxxflags -fno-stack-protector   #gcc < 4.0
	 #fi
	 
	#if [[ $(gcc-major-version) -lt 5 ]]; then
		#append-cxxflags  -std=gnu++11  #gcc < 5.0
	 #fi
	    
	#if [[ $(gcc-major-version) -ge 5 ]]; then
		#append-cxxflags  -std=gnu++14  #gcc >= 5.0
		#epatch "${FILESDIR}/${PN}3-gcc7.patch" || die "patch failed"
	 #fi  
	
	use_if_iuse qt4 && cd ${S}/gb.qt4 && \
		econf $(use_enable qt4-opengl qtopengl) \
			$(use_enable qt4-webkit qtwebkit)

	#use_if_iuse qt5 && cd ${S}/gb.qt5 && \
		#econf $(use_enable qt5-opengl qtopengl) \
			#$(use_enable qt5-webkit qtwebkit)

	  cd ${S} && econf $(use_enable bzip2 bzlib2) \
		$(use_enable cairo) \
		$(use_enable crypt) \
		$(use_enable curl) \
		$(use_enable dbus) \
		$(use_enable examples) \
		$(use_enable gmp) \
		$(use_enable gnome keyring) \
		$(use_enable gsl) \
		$(use_enable gstreamer media) \
		$(use_enable gtk2) \
		$(use_enable gtk3) \
		$(use_enable httpd) \
		$(use_enable image-imlib imageimlib) \
		$(use_enable image-io imageio) \
		$(use_enable jit) \
		$(use_enable libxml) \
		$(use_enable mime) \
		$(use_enable mysql) \
		$(use_enable ncurses) \
		$(use_enable net) \
		$(use_enable odbc) \
		$(use_enable openal) \
		$(use_enable opengl) \
		$(use_enable openssl) \
		$(use_enable pcre) \
		$(use_enable pdf) \
		$(use_enable postgres postgresql) \
		$(use_enable qt4) \
		$(use_enable qt5) \
		$(use_enable sdl) \
		$(use_enable sdl-sound sdlsound) \
		$(use_enable sqlite sqlite3) \
		$(use_enable v4l) \
		$(use_enable x11) \
		$(use_enable xml) \
		$(use_enable zlib)
        
	sed -i "249s|CPPFLAGS =|CPPFLAGS = -std=gnu++14|g" ${S}/gb.qt5/src/ext/Makefile || die
	sed -i "259s|CPPFLAGS =|CPPFLAGS = -std=gnu++14|g" ${S}/gb.qt5/src/opengl/Makefile || die
	sed -i "257s|CPPFLAGS =|CPPFLAGS = -std=gnu++14|g" ${S}/gb.qt5/src/webkit/Makefile || die
	sed -i "326s|CPPFLAGS =|CPPFLAGS = -std=gnu++14|g" ${S}/gb.qt5/src/Makefile || die
}

src_install() {  
	cd "${S}"
	make -j1 DESTDIR="${D}" install-strip 
	#make -j1 destdir="${D}" install
	  #cd "${S}"/gb.main && make -j12 DESTDIR="${D}" install-strip && cd "${S}"
      #cd "${S}"/gb.main/lib && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.dbus && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.desktop.x11 && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.compress.dbus && make -j12 DESTDIR="${D}" install  && cd "${S}"
	  cd "${S}"/gb.qt5 && make -j1 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.cairo && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.qt4 && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.qt4/src && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.compress.zlib && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.compress.gsl && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.gtk && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.gtk3 && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.gmp && make -j12 DESTDIR="${D}" install && cd "${S}"
      #cd "${S}"/gb.net && make -j12 DESTDIR="${D}" install && cd "${S}"
      #cd "${S}"/gb.net.curl && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.ncurses && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.media && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.libxml && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.mime && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.db.mysql && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.db.odbc && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.db.sqlite2 && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.db.sqlite3 && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.desktop.gnome.keyring && make -j12 DESTDIR="${D}" install && cd "${S}"
  	  cd "${S}"/gb.openal && make -j1 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.opengl && make -j12 DESTDIR="${D}" install && cd "${S}"
	  #cd "${S}"/gb.openssl && make -j12 DESTDIR="${D}" install && cd "${S}"
      #cd "${S}"/gb.pcre && make -j12 DESTDIR="${D}" install && cd "${S}"
      #cd "${S}"/gb.sdl && make -j12 DESTDIR="${D}" install-strip && cd "${S}"
      #cd "${S}"/gb.sdl && make -j12 destdir="${D}" install && cd "${S}"
      #cd "${S}"/gb.sdl.sound && make -j12 DESTDIR="${D}" install && cd "${S}"
      #cd "${S}"/gb.app && make -j12 ROOT="${D}" install && cd "${S}"
      #cd "${S}"/gb.comp && make -j12 ROOT="${D}" install && cd "${S}"
            
	#find . -name \*.la | xargs "${S}" --mode=clean rm -f
	#prune_libtool_files --all
			
	einstalldocs
	#dodoc AUTHORS ChangeLog NEWS README

	if use net ; then
		newdoc gb.net/src/doc/README gb.net-README
		newdoc gb.net/src/doc/changes.txt gb.net-ChangeLog
	fi

	if use pcre ; then
		newdoc gb.pcre/src/README gb.pcre-README
	fi

	if use qt4 ; then
		doicon "${S}/app/desktop/${MY_PN}.svg"
		domenu "${S}/app/desktop/${MY_PN}.desktop"

		doicon -s 64 -c mimetypes \
			"${S}/app/mime/application-x-gambasscript.png" \
			"${S}/app/mime/application-x-gambasserverpage.png" \
			"${S}/main/mime/application-x-gambas3.png"

		insinto /usr/share/mime/application
		doins "${S}/app/mime/application-x-gambasscript.xml" \
			"${S}/app/mime/application-x-gambasserverpage.xml" \
			"${S}/main/mime/application-x-gambas3.xml"
	fi
      
      prune_libtool_files --modules
}

pkg_preinst() {
	if use qt4 ; then
		gnome2_icon_savelist
	fi
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	if use qt4 ; then
		gnome2_icon_cache_update
	fi
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update

	if use qt4 ; then
		gnome2_icon_cache_update
	fi
}
