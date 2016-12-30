# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="6"

inherit multilib unpacker

DESCRIPTION="FastoRedis it is GUI platform for NoSQL databases"
HOMEPAGE="www.fastoredis.com"
SRC_URI="https://dl.opendesktop.org/api/files/download/id/1483084159/${P}-x86_64.deb"

LICENSE="GPL-v3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=">=sys-libs/libstdc++-v3-3.3.6-r1
        dev-libs/cyrus-sasl"
DEPEND="${RDEPEND}
        >=dev-qt/qtcore-5.4.0:5
		>=dev-qt/qtgui-5.4.0:5
		>=dev-qt/qtwebkit-5.4.0:5"

S=${WORKDIR}

#RESTRICT="strip"

src_install() {
	
    sed -i '3s|Exec=fastonosql|Exec=fastonosql.sh|g' "${S}/opt/${PN}/share/applications/${PN}.desktop" || die
	sed -i '7s|Icon=fastonosql.png|Icon=fastonosql|g' "${S}/opt/${PN}/share/applications/${PN}.desktop" || die
	sed -i '9s|IDE;redis;|IDE;|g' "${S}/opt/${PN}/share/applications/${PN}.desktop" || die
	
	dodir /usr/{bin,$(get_libdir),share}  
	mv "${S}"/opt/${PN}/{bin,share}  "${D}"/usr/
	
	cp -pPR "${WORKDIR}"/* "${D}"/ || die "copying files failed!"
	#dosym /opt/${PN}/lib/libsasl2.so.2 /usr/lib/libsasl2.so.2 || die
	dosym /usr/$(get_libdir)/libsasl2.so.3 /usr/$(get_libdir)/libsasl2.so.2
}
