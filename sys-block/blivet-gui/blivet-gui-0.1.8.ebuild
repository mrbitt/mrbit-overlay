# Copyright 2004-2014 Sabayon
# Distributed under the terms of the GNU General Public License v2
# $

EAPI="3"
#DOCS=( README )

inherit base distutils

DESCRIPTION="pykickstart is a python library that is used for reading and writing kickstart files."
HOMEPAGE="http://fedoraproject.org/wiki/Pykickstart"
SRC_URI="http://github.com/vojtechtrefny/blivet-gui/archive/${PV}.zip"

LICENSE="GPL-2"
KEYWORDS="~amd64 ~x86"

SLOT="0"

DEPEND="dev-python/python-blivet
	dev-python/pygobject
	dev-python/urlgrabber
	dev-python/pyparted"
RDEPEND="${DEPEND}"

src_install() {
       mv blivetgui/po/en_US.po blivetgui/po/LOCALE=en_US.po || die "rename files failed!"
       mkdir -p "${D}"/usr/{bin,share/{polkit-1/actions,doc,locale,applications}}
       python2 setup.py install --root="${D}" --optimize=1
       cp org.fedoraproject.pkexec.blivet-gui.policy "${D}"/usr/share/polkit-1/actions || die "copying files failed!"
       cp ${PN}.desktop "${D}"/usr/share/applications || die "copying files failed!"
       cp -pPR blivetgui/i18n/* "${D}"/usr/share/locale || die "copying files failed!"
       dodoc README.txt
       #make_desktop_entry "${PN}" "${PN}" "${PN}" "System;"
}