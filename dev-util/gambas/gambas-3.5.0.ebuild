# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-util/gambas/gambas-2.20.2.ebuild,v 1.3
# 2010/02/10 22:09:36 ssuominen, modified 2010/08/02 by lalebarde : dev-db/postgresql-base
# instead of virtual/postgresql-baseExp $


EAPI="2"


inherit autotools eutils fdo-mime multilib toolchain-funcs


DESCRIPTION="Gambas is a free development environment based on a Basic interpreter with object extensions"
HOMEPAGE="http://gambas.sourceforge.net/"


SLOT="3"
MY_PN="${PN}${SLOT}"
MY_P="${MY_PN}-${PV}"
SRC_URI="mirror://sourceforge/${PN}/${MY_P}.tar.bz2"
LICENSE="GPL-2"


KEYWORDS="~amd64 ~x86"
IUSE="
	bzip2 corba curl debug doc examples firebird gtk mysql odbc opengl pcre
	pdf postgres qt3 sdl smtp sqlite sqlite3 svg v4l xml zlib
"


COMMON_DEPEND="
	bzip2?	( >=app-arch/bzip2-1.0.5 )
	corba?	( >=net-misc/omniORB-4.1.0 )
	curl?	( >=net-misc/curl-7.15.5-r1 )
	firebird?	( >=dev-libs/ibpp-2.5.3.1 )
	gtk?	(
		>=x11-libs/gtk+-2.10.14
		svg?	( >=gnome-base/librsvg-2.16.1-r2 )
	)
	mysql?	( >=virtual/mysql-5.0 )
	odbc?	( >=dev-db/unixODBC-2.2.12 )
	opengl?	( >=media-libs/mesa-7.0.2 )
	pcre?	( >=dev-libs/libpcre-7.6-r1 )
	pdf?	( >=app-text/poppler-0.12.3-r3 )
	postgres?	( >=dev-db/postgresql-base-8.2 )
	qt3? ( x11-libs/qt-core[qt3support] )
	sdl?	(
		>=media-libs/sdl-image-1.2.6-r1
		>=media-libs/sdl-mixer-1.2.7
	)
	smtp?	( >=dev-libs/glib-2.16.2 )
	sqlite?	( =dev-db/sqlite-2* )
	sqlite3?	( >=dev-db/sqlite-3.5.6 )
	v4l?	(
		>=media-libs/libpng-1.2.26
		>=media-libs/jpeg-6b-r8
	)
	xml?	(
		>=dev-libs/libxml2-2.6.31
		>=dev-libs/libxslt-1.1.22
	)
	zlib?	( >=sys-libs/zlib-1.2.3-r1 )
	virtual/libffi
"
DEPEND="${COMMON_DEPEND}
	dev-util/pkgconfig
"
RDEPEND="${COMMON_DEPEND}"


S=${WORKDIR}/${MY_P}


pkg_setup() {
	# ImageProvider implementers, see .component files for more info
	if ! { use qt3 || use gtk || use sdl; } ; then
		use pdf && die "PDF support depends on Qt, GTK or SDL being enabled"
		use v4l && die "V4L support depends on Qt, GTK or SDL being enabled"
	fi


	# OpenGLViewer implementers, see .component files for more info
	if ! { use qt3 || use sdl; } ; then
		use opengl && die "OpenGL support depends on Qt or SDL being enabled"
	fi


	if ! use gtk; then
		use svg && die "SVG support depends on GTK being enabled"
	fi


	if ! use qt3; then
		einfo
		ewarn "The Gambas IDE currently cannot be be build without Qt being enabled."
		if use gtk; then
			einfo
			ewarn "You are using the USE flag gtk, but not qt3.  Attempting to use GTK instead"
			ewarn "of Qt for certain components.  This is considered EXPERIMENTAL and the"
			ewarn "resulting components may not function."
		fi
		einfo
		ebeep 3
	fi
}


my_reduce_eautoreconf() {
	sed -i -e "/^\(AC\|GB\)_CONFIG_SUBDIRS(${1}[,)]/d" \
	configure.ac \
	|| die "my_reduce_eautoreconf: sed on configure.ac failed with ${1}"


	sed -i -e "/^SUBDIRS/s/\ \(@${1}_dir@\|${1}\)//1" \
	Makefile.am \
	|| die "my_reduce_eautoreconf: sed on Makefile.am failed with ${1}"
}


my_examine_components() {
	local comp="gb.*/src/*.component gb.*/src/*/*.component main/lib/*/*.component comp/src/*/.component"


	# Examine app/src/gambas2/CComponent.class for more info
	echo
	einfo "Checking component files ..."
	einfo
	elog "The following components are reported stable, but incomplete:"
	elog "$(grep '^State=1' ${comp} | sed -e 's/.*\(gb\.[^/]*\)[/]\?\.component.*/\1/')"
	einfo
	ewarn "The following components are reported unstable:"
	ewarn "$(grep '^\(State=2\|Alpha\)' ${comp} | sed -e 's/.*\(gb\.[^/]*\)[/]\?\.component.*/\1/')"
	echo
}

src_prepare() {
      ./reconf-all
      my_examine_components
      epatch "${FILESDIR}/svn-r1636-xdg-utils.patch"
}

src_configure() {
	
	# --without-xdg-utils comes from svn-r1636-xdg-utils.patch
	econf --config-cache --docdir=/usr/share/doc/${PF} --htmldir=/usr/share/doc/${PF}/html
}


my_dekstop_and_icon() {
	# USAGE: <executable> <name> <category> <icon_source_file> <icon_target_dir>
	local icon="${1}.png"


	make_desktop_entry "${1}" "${2}" "${5}/${icon}" "${3}" \
	|| die "make_desktop_entry failed for ${1}"


	insinto ${5}
	newins ${4} ${icon} || die "newins failed for ${1}"
}


src_compile() {
	emake LIBTOOLFLAGS="--quiet" || die "emake failed"
}


src_install() {
	mkdir "${D}"/usr/share/gambas3/mime
	emake DESTDIR="${D}" LIBTOOLFLAGS="--quiet" install -j1 || die "emake install failed"


	dodoc AUTHORS ChangeLog NEWS README || die "dodoc failed"
	newdoc gb.net/src/doc/README gb.net-README || die "newdoc failed"
	newdoc gb.net/src/doc/changes.txt gb.net-ChangeLog || die "newdoc failed"
	use pcre && { newdoc gb.pcre/src/README gb.pcre-README || die "newdoc failed"; }


	if { use qt3 || use gtk; } ; then
		# Remove qt3 test when it works without it
		use qt3 && \
		my_dekstop_and_icon \
		"${MY_PN}" "Gambas" "Development" \
		"app/src/${MY_PN}/img/logo/new-logo.png" \
		"/usr/share/icons/hicolor/128x128/apps"


		my_dekstop_and_icon \
		"${MY_PN}-database-manager" "Gambas Database Manager" "Development" \
		"app/src/${MY_PN}-database-manager/img/logo/logo-128.png" \
		"/usr/share/icons/hicolor/128x128/apps"


		insinto /usr/share/icons/hicolor/64x64/mimetypes
		doins app/mime/*.png main/mime/*.png || die "doins failed"


		insinto /usr/share/mime/application
		doins app/mime/*.xml main/mime/*.xml || die "doins failed"
	fi


	use doc && { dosym "/usr/share/${MY_PN}/help" "/usr/share/doc/${PF}/html" \
	|| die "dosym failed"; }
}


my_fdo_update() {
	{ use qt3 || use gtk; } && fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
}


pkg_postinst() {
	my_fdo_update
}


pkg_postrm() {
	my_fdo_update
}

