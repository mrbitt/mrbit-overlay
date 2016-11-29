# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools

DESCRIPTION="OpenSSH SFTP Server"
HOMEPAGE="http://mysecureshell.sourceforge.net"
SRC_URI="http://mysecureshell.free.fr/repository/index.php/source/${PN}_${PV}.tar.gz"

LICENSE="GPLv2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="admin"

DEPEND="net-misc/openssh"
S=${WORKDIR}/${PN}_${PV}
src_unpack() {
	unpack ${A}

}

src_compile() {
	econf \
		$(use_with admin)

	emake || die
}

src_install() {
	# sftp_config installation
	insinto /etc/ssh
	doins "${S}"/sftp_config
	fperms 640 /etc/ssh/sftp_config

	# binary installation
	insinto /usr/bin
	doins "${S}"/MySecureShell
	fperms 4755 /usr/bin/MySecureShell

	# tools installation
	for f in sftp-{who,kill,verif,user} ; do
		doins "${S}/utils/"/${f}
	        fperms 755 /usr/bin/${f}
	done

	# admin installation
	for f in sftp-{state,admin} ; do
		doins "${S}/utils/"/${f}
	        fperms 700 /usr/bin/${f}
	done

	#install MySecureShell to /etc/shells ( from the install-sh )
	grepshell=`grep /bin/MySecureShell /etc/shells`
	if [ "$?" = "0" ] ; then
		elog "MySecureShell is present into /etc/shells"
	else
		elog "MySecureShell is not found in your /etc/shells : please add it with echo "/bin/MySecureShell" >> /etc/shells"
	fi
	
}
