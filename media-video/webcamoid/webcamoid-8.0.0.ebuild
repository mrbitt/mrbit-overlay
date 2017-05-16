# Copyright 2011-2013 Gonzalo Exequiel Pedone
# Distributed under the terms of the GNU General Public License v3

EAPI="6"
PLOCALES="ca de el es et fr gl it ja ko pt ru zh_CN zh_TW"
inherit l10n qmake-utils versionator

DESCRIPTION="qt5 Webcamoid, the full webcam and multimedia suite."
HOMEPAGE="https://github.com/hipersayanX/webcamoid"
#SRC_URI="https://github.com/hipersayanX/webcamoid/archive/${PV}.tar.gz"
SRC_URI="https://github.com/${PN}/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPLv3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="doc headers jack pulseaudio"

RDEPEND="dev-qt/qtwidgets:5
	 dev-qt/qtgui:5
	 dev-qt/qtcore:5
	 dev-qt/qtsvg:5
	 dev-qt/qtquickcontrols
	 dev-qt/qtscript:5
	 dev-qt/qtgui
     dev-qt/qtnetwork:5
	 dev-qt/qtopengl:5
	     sys-devel/bison
         sys-devel/flex
         >=media-libs/gstreamer-1.6.0
	     >=media-video/ffmpeg-2.8.0:=
         media-plugins/frei0r-plugins
         media-libs/libv4l
	jack? ( virtual/jack )
	pulseaudio? ( media-sound/pulseaudio ) "

DEPEND="${RDEPEND}
        >=sys-kernel/linux-headers-3.6
	    virtual/pkgconfig
	  doc? ( dev-qt/qdoc )"

DOCS=( AUTHORS CONTRIBUTING.md ChangeLog README.md THANKS )

#src_unpack() {
        #unpack "${PV}.tar.gz"
        #mv -v "Webcamoid-${PV}" "${P}"       
#}
src_prepare() {
	local tsdir="${S}/StandAlone/share/ts"
	local mylrelease="$(qt5_get_bindir)"/lrelease

	prepare_locale() {
		"${mylrelease}" "${tsdir}/${1}.ts" || die "preparing ${1} locale failed"
	}

	rm_locale() {
		sed -i \
			-e '/.*share\/ts\/'${1}'\.qm.*/d' \
			StandAlone/translations.qrc || die
	}

	rm ${tsdir}/*.qm

	l10n_find_plocales_changes "${tsdir}" "" '.ts'
	l10n_for_each_locale_do prepare_locale
	l10n_for_each_disabled_locale_do rm_locale

	default
}

src_compile() {
    eqmake5 "PREFIX=/usr" \
		"BUILDDOCS=$(usex doc 1 0)" \
		"INSTALLDEVHEADERS=$(usex headers 1 0)"
    #eqmake5  Webcamoid.pro
    #emake || die
}

src_install() {
    emake INSTALL_ROOT="${D}" install || die
    use doc && einstalldocs
}
