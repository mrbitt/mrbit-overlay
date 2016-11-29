# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"
inherit eutils

DESCRIPTION="Support for printing to ZjStream-based printers"
HOMEPAGE="http://foo2zjs.rkkda.com/"

# extracted by http://gentooexperimental.org/~genstef/dist/foo2zjs-helper.sh
DEVICES=( "hp1025" "hp1215" "hp1500" "hp1600" "hp2600n" "km1600w" "km1680"
"km1690" "km2480" "km2490" "km2530" "km4690" "xp6115" "oki110" "xp6121"
"km2200" "km2300" "km2430" "kmcpwl" "sa300" "sa310" "sa315" "sa2160"
"sa3160" "sa3175" "xp6110" "lexc500" "oki3100" "oki3200" "oki3300" "oki3400"
"oki3530" "oki5100" "oki5200" "oki5500" "oki5600" "oki5800" "ov160" "hp1000"
"hp1005" "hp1018" "hp1020" "hpp1005" "hpp1006" "hpp1007" "hpp1008" "hpp1505" )

#"sa610" and "sa610" has no file to download
URIS=(
"http://foo2zjs.rkkda.com/icm/hp-cp1025.tar.gz"
"http://foo2hp.rkkda.com/icm/hpclj2600n.tar.gz http://foo2zjs.rkkda.com/icm/km2430.tar.gz http://foo2hp.rkkda.com/icm/hp1215.tar.gz"
"http://foo2hp.rkkda.com/icm/hpclj2500.tar.gz http://foo2hp.rkkda.com/icm/hpclj2600n.tar.gz"
"http://foo2hp.rkkda.com/icm/hpclj2600n.tar.gz http://foo2zjs.rkkda.com/icm/km2430.tar.gz http://foo2hp.rkkda.com/icm/hp1215.tar.gz"
"http://foo2hp.rkkda.com/icm/hpclj2600n.tar.gz http://foo2zjs.rkkda.com/icm/km2430.tar.gz http://foo2hp.rkkda.com/icm/hp1215.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2lava.rkkda.com/icm/km2530.tar.gz http://foo2lava.rkkda.com/icm/km-1600.tar.gz"
"http://foo2zjs.rkkda.com/icm/dl2300.tar.gz"
"http://foo2zjs.rkkda.com/icm/dl2300.tar.gz http://foo2zjs.rkkda.com/icm/km2430.tar.gz"
"http://foo2zjs.rkkda.com/icm/km2430.tar.gz"
"http://foo2zjs.rkkda.com/icm/dl2300.tar.gz"
"http://foo2qpdl.rkkda.com/icm/samclp300.tar.gz http://foo2qpdl.rkkda.com/icm/samclp315.tar.gz"
"http://foo2qpdl.rkkda.com/icm/samclp300.tar.gz http://foo2qpdl.rkkda.com/icm/samclp315.tar.gz"
"http://foo2qpdl.rkkda.com/icm/samclp300.tar.gz http://foo2qpdl.rkkda.com/icm/samclp315.tar.gz"
"http://foo2qpdl.rkkda.com/icm/samclp300.tar.gz http://foo2qpdl.rkkda.com/icm/samclp315.tar.gz"
"http://foo2qpdl.rkkda.com/icm/samclp300.tar.gz http://foo2qpdl.rkkda.com/icm/samclp315.tar.gz"
"http://foo2qpdl.rkkda.com/icm/samclp300.tar.gz http://foo2qpdl.rkkda.com/icm/samclp315.tar.gz"
"http://foo2qpdl.rkkda.com/icm/samclp300.tar.gz http://foo2qpdl.rkkda.com/icm/samclp315.tar.gz"
"http://foo2slx.rkkda.com/icm/lexc500.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic3200.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic3200.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic3400.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic3400.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic3400.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic3200.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic3200.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic5600.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic5600.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic5600.tar.gz"
"http://foo2hiperc.rkkda.com/icm/okic5600.tar.gz"
"http://foo2zjs.rkkda.com/firmware/sihp1000.tar.gz"
"http://foo2zjs.rkkda.com/firmware/sihp1005.tar.gz"
"http://foo2zjs.rkkda.com/firmware/sihp1018.tar.gz"
"http://foo2zjs.rkkda.com/firmware/sihp1020.tar.gz"
"http://foo2zjs.rkkda.com/firmware/sihpP1005.tar.gz"
"http://foo2zjs.rkkda.com/firmware/sihpP1006.tar.gz"
"http://foo2zjs.rkkda.com/firmware/sihpP1005.tar.gz"
"http://foo2zjs.rkkda.com/firmware/sihpP1006.tar.gz"
"http://foo2zjs.rkkda.com/firmware/sihpP1505.tar.gz" )

#SRC_URI="http://dev.gentooexperimental.org/~scarabeus/${P}.tar.gz"
SRC_URI="http://foo2zjs.rkkda.com/${PN}.tar.gz"
IUSE="cups foomaticdb usb"
for ((DEV=0; DEV < ${#DEVICES[*]}; DEV++)); do
	SRC_URI="${SRC_URI} foo2zjs_devices_${DEVICES[DEV]}? ( ${URIS[DEV]} )"
	IUSE="${IUSE} foo2zjs_devices_${DEVICES[DEV]}"
	ALL_BEGIN="${ALL_BEGIN} !foo2zjs_devices_${DEVICES[DEV]}? ("
	ALL_MIDDLE="${ALL_MIDDLE} ${URIS[DEV]}"
	ALL_END="${ALL_END} )"
done
SRC_URI="${SRC_URI}${ALL_BEGIN}${ALL_MIDDLE}${ALL_END}"

LICENSE="GPL-2"
# due to those firmwares/icms/etc...
RESTRICT="mirror"
SLOT="0"
DEPEND="app-arch/unzip"
RDEPEND="cups? ( net-print/cups )
	foomaticdb? ( net-print/foomatic-db-engine )
	net-print/foomatic-filters
	sys-fs/udev"
KEYWORDS="~x86 ~amd64 ~ppc"
S=${WORKDIR}/${PN}

src_unpack() {
	unpack ${PN}.tar.gz
	# link getweb files in ${S} to get unpacked
	for i in ${A}
	do
		ln -s "${DISTDIR}"/${i} "${S}"
	done
	cd "${S}"
}



src_compile() {
	emake getweb || die "Failed building getweb script"
	# remove wget as we got the firmware with portage
	sed -i -e "s/.*wget .*//" \
		-e 's/.*rm $.*//' \
		-e "s/error \"Couldn't dow.*//" getweb
	# unpack files
	GOT=0;
	for ((DEV=0; DEV < ${#DEVICES[*]}; DEV++)); do
		if use foo2zjs_devices_${DEVICES[DEV]}; then
			./getweb ${DEVICES[DEV]:2}
			GOT=1
		fi
	done
	if [ ${GOT} == 0 ]; then ./getweb all; fi
	emake || die "emake failed"
}

src_install() {
	use foomaticdb && dodir /usr/share/foomatic/db/source
	use cups && dodir /usr/share/cups/model
	emake DESTDIR="${D}" install \
		|| die "emake install failed"
}
