# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
RESTRICT="mirror"

inherit cmake-utils eutils flag-o-matic

SLOT="2.6"

DESCRIPTION="Core libraries for media-video/avidemux"
HOMEPAGE="http://fixounet.free.fr/avidemux"

# Multiple licenses because of all the bundled stuff.
LICENSE="GPL-1 GPL-2 MIT PSF-2 public-domain"
IUSE="debug nls sdl system-ffmpeg vaapi vdpau video_cards_fglrx xv"
KEYWORDS="amd64 ~x86"

MY_PN="${PN/-core/}"
if [[ ${PV} == *9999* ]] ; then
	MY_P=$P
	KEYWORDS=""
	PROPERTIES="live"
	EGIT_REPO_URI="git://gitorious.org/${MY_P}2-6/${MY_P}2-6.git https://git.gitorious.org/${MY_P}2-6/${MY_P}2-6.git"
	EGIT_REPO_URI="https://github.com/mean00/${MY_P}2"
	inherit git-r3
else
	MY_P="${MY_PN}_${PV}"
	SRC_URI="mirror://sourceforge/${MY_PN}/${MY_PN}/${PV}/${MY_P}.tar.gz"
fi

# Trying to use virtual; ffmpeg misses aac,cpudetection USE flags now though, are they needed?
DEPEND="
	!<media-video/avidemux-${PV}:${SLOT}
	dev-db/sqlite:3
	sdl? ( media-libs/libsdl:0 )
	system-ffmpeg? ( >=virtual/ffmpeg-9:0[mp3,theora] )
	xv? ( x11-libs/libXv:0 )
	vaapi? ( x11-libs/libva:0 )
	vdpau? ( x11-libs/libvdpau:0 )
	video_cards_fglrx? (
		|| ( >=x11-drivers/ati-drivers-14.12-r3
			x11-libs/xvba-video:0 )
		)"
RDEPEND="
	$DEPEND
	nls? ( virtual/libintl:0 )
"
DEPEND="
	$DEPEND
	virtual/pkgconfig
	nls? ( sys-devel/gettext )
	!system-ffmpeg? ( dev-lang/yasm[nls=] )
"

S="${WORKDIR}/${MY_P}"
BUILD_DIR="${S}/buildCore"

DOCS=( AUTHORS README )

src_prepare() {
	mkdir "${BUILD_DIR}" || die "Can't create build folder."

	#cmake-utils_src_prepare

	if use system-ffmpeg ; then
		# Preparations to support the system ffmpeg. Currently fails because it depends on files the system ffmpeg doesn't install.
		local error="Failed to remove ffmpeg."

		rm -rf cmake/admFFmpeg* cmake/ffmpeg* avidemux_core/ffmpeg_package buildCore/ffmpeg || die "${error}"
		sed -i \
			-e 's/include(admFFmpegUtil)//g' \
			-e '/registerFFmpeg/d' \
			-- cmake/commonCmakeApplication.cmake || die "${error}"
		sed -i \
			-e 's/include(admFFmpegBuild)//g' \
			-- avidemux_core/CMakeLists.txt || die "${error}"
	else
		# Avoid existing avidemux installations from making the build process fail, bug #461496.
		sed -i -e "s:getFfmpegLibNames(\"\${sourceDir}\"):getFfmpegLibNames(\"${S}/buildCore/ffmpeg/source/\"):g" cmake/admFFmpegUtil.cmake \
			|| die "Failed to avoid existing avidemux installation from making the build fail."
	fi

	# Add lax vector typing for PowerPC.
	if use ppc || use ppc64 ; then
		append-cflags -flax-vector-conversions
	fi

	# See bug 432322.
	use x86 && replace-flags -O0 -O1

	# Needed for gcc-6
	append-cxxflags $(test-flags-CXX -std=gnu++98)

	# Filter problematic flags
	filter-flags -fwhole-program -flto

	eapply_user
}

src_configure() {
	local mycmakeargs
	mycmakeargs=(
		-DAVIDEMUX_SOURCE_DIR="'${S}'"
		-DGETTEXT="$(usex nls)"
		-DSDL="$(usex sdl)"
		-DLIBVA="$(usex vaapi)"
		-DVDPAU="$(usex vdpau)"
		-DXVBA="$(usex video_cards_fglrx)"
		-DXVIDEO="$(usex xv)"
	)

	if use debug ; then
		mycmakeargs+=( -DVERBOSE=1 -DCMAKE_BUILD_TYPE=Debug -DADM_DEBUG=1 )
	fi

	CMAKE_USE_DIR="${S}"/avidemux_core cmake-utils_src_configure
}

src_compile() {
	cmake-utils_src_compile -j1
}

src_install() {
	# revert edit from src_prepare prior to installing
	sed -i -e "s:getFfmpegLibNames(\"${S}/buildCore/ffmpeg/source/\"):getFfmpegLibNames(\"\${sourceDir}\"):g" cmake/admFFmpegUtil.cmake
	cmake-utils_src_install -j1
}
