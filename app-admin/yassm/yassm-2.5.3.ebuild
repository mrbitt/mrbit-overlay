# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils unpacker

DESCRIPTION="A GUI for managing system Samba mount"
HOMEPAGE="hftp.nluug.nl/os/Linux/distr/quirky/quirky6/sources/alphabetical/y/"
SRC_URI="http://ftp.nluug.nl/ibiblio/distributions/fatdog/packages/710/${P}-noarch-1.txz"
    
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="net-fs/cifs-utils
		 x11-libs/gksu
		 x11-misc/xdialog
		 x11-misc/gtkdialog"

S="${WORKDIR}"

src_prepare() {
	 cd "${S}"/usr/local/yassm/
	 
	for file in $(find . -type f -print); do
       sed -e "s/gtkdialog3/gtkdialog/" -i $file || die
       sed -e "s/gtksu/gksu/" -i $file || die
    done
    
    cd "${S}"/usr/share/applications/
    sed -i samba*.desktop -e 's:Network:Network;:' || die "sed failed"

}

src_install() {
   cp -pPR "${S}"/* "${D}"/ || die "copying files failed!"
   #make DESTDIR="${D}" install
   rm -Rd "${D}"/install || die
}
