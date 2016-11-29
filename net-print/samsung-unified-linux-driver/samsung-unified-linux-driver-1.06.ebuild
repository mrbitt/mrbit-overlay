# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/apr-util/apr-util-1.3.9.ebuild,v 1.12 2009/11/04 12:12:05 arfrever Exp $

EAPI=4

inherit multilib versionator

DESCRIPTION="Samsung's proprietary printer driver binaries known as UnifiedLinuxDriver"
HOMEPAGE="http://www.samsung.com/us/support/downloads/ML-6512MD/XAA"
SRC_URI="http://org.downloadcenter.samsung.com/downloadfile/ContentsFile.aspx?CDSite=UNI_IT&CttFileID=6284178&CDCttType=DR&ModelType=N&ModelName=CLX-3185&VPath=DR/201510/20151027150548393/uld_v1.00.36_00.91.tar.gz"

LICENSE="SAMSUNG-ELECTRONICS-software-1.06"
SLOT="0"
#KEYWORDS="~amd64 ~arm ~x86 -*"
KEYWORDS="~amd64 ~x86 -*"
IUSE="+splix"

S=${WORKDIR}/uld

# We need libstdc++.so.5
# Splix and we both try to install CMS (color management stuff)
# files. The splix useflag allows the two packages to not clobber
# eachother.
RDEPEND="net-print/cups
	splix? ( net-print/splix )
	!splix? ( !net-print/splix )"

QA_SONAME='/usr/lib[^/]*/libscmssc.so'
QA_FLAGS_IGNORED="/usr/libexec/cups/filter/rastertospl.* ${QA_SONAME}"
QA_PRESTRIPPED=${QA_FLAGS_IGNORED}

pkg_setup() {
	local abi="${ABI}"

	# does non-portage-multilib take significance in ${ABI}?
	[ -z "${abi}" ] && abi="${ARCH}"

	# Samsung's choice for how to denote ABIs and libdir within its
	# tarball.
	case ${abi} in
		x86)
			SABI=i386
			;;
		amd64)
			SABI=x86_64
			;;
		*)
			SABI=${abi}
			;;
	esac
}

src_install() {
	# Currently, we try to install the minimum necessary for
	# integrating into CUPS. The UI may come later with a qt4
	# useflag... but having a working driver is much more useful than
	# a GUI.

	insinto /usr/share/ppd
	doins noarch/share/ppd/*.ppd

	if ! use splix; then
		# rastertosamsungsplc looks for the *.cts file here of
		# its own arbitrary choosing.
		insinto /usr/share/cups/model/samsung
		doins -r noarch/share/ppd/cms
	fi

	# I think that sane support needs the smfpd to be installed and
	# running...(?) [this copy of 1.05 doesn't include sane.d stuff)
	#insinto /etc/sane.d
	#doins -r noarch/at_root/etc/sane.d/*

	# required only for scanning?
	#dosbin ${SABI}/at_root/usr/sbin/smfpd

	exeinto /usr/libexec/cups/filter
	doexe ${SABI}/rasterto*

	# libscmssc.so must currently be placed into the system library
	# search path to be found by the various raster filters when they
	# try “dlopen("libscmssc.so")”.
	dolib ${SABI}/libscmssc.so
}

pkg_postinst() {
	local v
	for v in "${REPLACING_VERSIONS[@]}"; do
		version_is_at_least 1.06 "${v}" && continue
		# Suggested by dwfreed.
		ewarn "After upgrading from ${PN}-1.05 or older, you must"
		ewarn "“modify” the printer (reassign the correct PPD) because"
		ewarn "the name of the CUPS filter executable has changed."
		break
	done
}
