# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit eutils python-single-r1 versionator

# TODO:
# matio? ( sci-libs/matio ) - in science overlay #269598 (wait for new release
# after 1.3.4) or until somebody adds it to the tree.

DESCRIPTION="VIPS Image Processing Library"
SRC_URI="http://www.vips.ecs.soton.ac.uk/supported/$(get_version_component_range 1-2)/${P}.tar.gz"
HOMEPAGE="http://vips.sourceforge.net"

LICENSE="LGPL-2.1"
SLOT="0/35"
KEYWORDS="~amd64 ~x86"
IUSE="debug exif fits fftw gsf imagemagick jpeg lcms openexr +orc png python static-libs tiff webp"

RDEPEND="
	>=dev-libs/glib-2.32:2
	>=dev-libs/gobject-introspection-1.30
	>=dev-libs/liboil-0.3
	dev-libs/libxml2
	sys-libs/zlib
	>=x11-libs/pango-1.8

	exif? ( >=media-libs/libexif-0.6 )
	fits? ( sci-libs/cfitsio )
	fftw? ( sci-libs/fftw:3.0 )
	gsf? ( >=gnome-extra/libgsf-1.14.27 )
	imagemagick? (
		|| ( >=media-gfx/imagemagick-5.0.0
			media-gfx/graphicsmagick[imagemagick] ) )
	jpeg? ( virtual/jpeg:0 )
	lcms? ( media-libs/lcms:2 )
	openexr? ( >=media-libs/openexr-1.2.2 )
	orc? ( >=dev-lang/orc-0.4.11 )
	png? ( >=media-libs/libpng-1.2.9:0 )
	python? (
		${PYTHON_DEPS}
		>=dev-python/pygobject-3.12:3[${PYTHON_USEDEP}] )
	tiff? ( media-libs/tiff:0 )
	webp? ( media-libs/libwebp )
"
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.14
	virtual/pkgconfig
"

pkg_setup() {
	use python && python-single-r1_pkg_setup
}

src_configure() {
	# debug handling still sucks but better have minimum than no
	econf \
		--disable-gtk-doc \
		$(usex debug yes minimum) \
		$(use_with exif libexif) \
		$(use_with fftw) \
		$(use_with fits cfitsio) \
		$(use_with gsf) \
		$(use_with imagemagick magick) \
		$(use_with jpeg) \
		$(use_with lcms) \
		$(use_with openexr OpenEXR) \
		$(use_with orc) \
		$(use_with png) \
		$(use_with python) \
		$(use_enable python pyvips8) \
		$(use_with tiff) \
		$(use_with webp libwebp) \
		$(use_enable static-libs static)
}

src_install() {
	emake DESTDIR="${D}" install || die
	dodoc AUTHORS ChangeLog NEWS THANKS TODO || die

	# 314101
	#mv "${ED}"/usr/share/doc/${P}/* "${ED}"/usr/share/doc/${PF} || die
	#rmdir "${ED}"/usr/share/doc/${P}/ || die
	#dosym /usr/share/doc/${PF} /usr/share/doc/${P}
    sed -i 's|^#!.*python$|&2|' "${D}/usr/bin/vipsprofile"
	prune_libtool_files
}
