# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"
inherit versionator java-utils-2 java-pkg-2 java-ant-2 gnome2-utils

#_minor=47

MY_P=$(version_format_string '${PN}-$1.$2.$3')

DESCRIPTION="Tor launcher and exit node chooser"
HOMEPAGE="http://www.dazzleships.net/?page_id=71"
#SRC_URI="http://www.dazzleships.net/?wpdmact=process&did=My5ob3RsaW5r -> ${P}-${_minor}_all.tar.gz"
SRC_URI="http://www.dazzleships.net/?wpdmact=process&did=NC5ob3RsaW5r -> ${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
IUSE="debug"

KEYWORDS="amd64 x86"

RDEPEND="net-misc/tor
        >=dev-java/proguard-4.8
        dev-java/icedtea-bin:7
        >=virtual/jdk-1.7"
DEPEND="${RDEPEND}"

#S="${WORKDIR}/${PN}_${PV}-${_minor}_all"
S="${WORKDIR}/${MY_P}"

src_prepare() {
	 cd "${S}"
	sed -i 's|Keywords=network;tor|Keywords=network;tor;|g' ${S}/packaging/applications/selektor-autostart.desktop  || die
	sed -i 's|Application;|Network;|g' ${S}/packaging/applications/selektor-autostart.desktop  || die
	
	sed -i 's|Keywords=network;tor|Keywords=network;tor;|g' ${S}/packaging/applications/selektor.desktop  || die
	sed -i 's|Categories=Network;Application;|Categories=Network;|g' ${S}/packaging/applications/selektor.desktop  || die
	
	sed -i 's|Keywords=network;tor|Keywords=network;tor;|g' ${S}/packaging/applications/selektor-proxy-reset.desktop  || die
	sed -i 's|Categories=Network;Application;|Categories=Network;|g' ${S}/packaging/applications/selektor-proxy-reset.desktop  || die

	sed -i -e 's|/usr/lib/jvm/default-java|/etc/java-config-2/current-system-vm/|g' SelekTOR.pro
	sed -i '18i -ignorewarnings' SelekTOR.pro
	sed -i -e "12s|-target 1.7| |g" SelekTOR.pro
}

src_configure(){
       cd "${S}"
}

src_compile() {
	cd "${S}"
	ewarn "
	      !!! eselect java-vm set system icedtea-bin-7 !!!
	      "
	./build-jar
}

src_install() {
    cd "${S}"
    dodir /usr/{bin,share}
    dodir /opt/${PN}
       install -D -m755 ${S}/SelekTOR.jar ${D}/opt/selektor/ || die
       mv ${S}/packaging/{applications,man,icons} "${D}/usr/share" -f || die
         sed -i -e "5s|/usr/share|/opt|g" ${S}/packaging/${PN}
       
       mv ${S}/packaging/${PN} "${D}/usr/bin/" -f || die
       chmod 755 "${D}/usr/bin/${PN}"
       
       cp -pPR ${S}/packaging/* ${D}/opt/${PN} || die "copying files failed!"
    rm -rf ${D}/opt/${PN}/DEBIAN
    
}

post_install() {
      elog "!!! eselect java-vm set system icedtea-bin-7 "
       fdo-mime_desktop_database_update
       fdo-mime_mime_database_update
       gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}