# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils 
DESCRIPTION="EditiX is a powerful and easy to use XML editor, Visual Schema Editor, XQuery Editor and XSLT debugger"
HOMEPAGE="http://free.editix.com/"
SRC_URI="http://www.editix.com/download/editix${PV}.tar.gz"

LICENSE="custom"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE=""

RDEPEND=">=virtual/jre-1.5"
	
DEPEND="${RDEPEND}"

S="${WORKDIR}"


src_install() {
	 # Licenses first, before we move the whole directory to opt
  cd "${S}/${PN}${PV}"
  for F in LICENSE.TXT ; do
    # Install to /usr and remove from distribution dir
    install -D -m644 $F "${D}/usr/share/licenses/${PN}/$F"
    rm -f $F
    # Symlink the original file from /opt to /usr
    ln -sf /usr/share/licenses/${PN}/$F $F
  done
   
   rm -rf "${D}/usr/share" || die
   
  # Install the compiled app to /opt
  cd "${S}"
  install -dm755 "${D}/opt/"
  cp -r editix${PV} ${D}/opt/

  # Create a symlink to /usr/bin
  install -dm755 "${D}/usr/bin/"
  ln -sf /opt/editix${PV}/bin/${PN}.sh "${D}/usr/bin/${PN}"  || die
  chmod 755 "${D}/opt/editix${PV}/bin/editix.sh" || die

  # Fix the run script
  sed -e "s|^TOPDIR=.*\$|TOPDIR='/opt/editix${PV}/bin/';|g" \
    -i "${D}/opt/editix${PV}/bin/editix.sh"
}
