# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils unpacker

DESCRIPTION="A GUI for managing system Samba mount"
HOMEPAGE="http://smokey01.com/saintless/DebianDog/Packages/Extra/"
SRC_URI="http://smokey01.com/saintless/DebianDog/Packages/Extra/yassm-smbclient-mpscan_2.6-1_i386.deb"
    
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND="net-fs/cifs-utils
		 x11-libs/gksu
		 x11-misc/xdialog
		 app-misc/rox-filer
		 x11-misc/gtkdialog"

S="${WORKDIR}"

src_prepare() {
	 cd "${S}"/usr/local/yassm/
	 
	for file in $(find . -type f -print); do
       sed -e "s/gtkdialog3/gtkdialog/" -i $file || die
       sed -e "s/gtksu/gksu/" -i $file || die
       sed -e "s/rox/thunar/" -i $file || die
       sed -e "s/umount/umount -l /" -i $file || die
       sed -e 's!mount.cifs //$IP/"$SHARE" $MYSHARE $AUTH!mount -t cifs $AUTH //$IP/"$SHARE" $MYSHARE!' -i $file || die
    done
    
    cd "${S}"/usr/share/applications/
     
   for file in $(find . -type f -print); do
       sed -e "s:Exec=gsu:Exec=gksu:" -i $file || die
   done
}

src_install() {
   cp -pPR "${S}"/* "${D}"/ || die "copying files failed!"
   #make DESTDIR="${D}" install
   rm -Rd "${D}"/usr/bin || die
}
