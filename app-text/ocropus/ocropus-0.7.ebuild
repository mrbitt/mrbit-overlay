# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="5"

PYTHON_DEPEND="2:2.7:2.7"
PYTHON_COMPAT=( python{2_6,2_7} )


inherit distutils-r1 mercurial

DESCRIPTION="OCR focusing on the use of large scale machine learning for addressing problems in document analysis"
HOMEPAGE="https://code.google.com/p/ocropus/"
EHG_REPO_URI="https://code.google.com/p/ocropus/"
EGIT_COMMIT="6c538ce2b387"

SRC_URI="http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/en-mixed-round1.lineest.gz
http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/frakant.pyrnn.gz
http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/fraktur.pyrnn.gz
http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/gradient.lineest.gz
http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/en-mixed.lineest.gz
http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/en-space.model.gz
http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/uw3unlv.pyrnn.gz
http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/en-uw3-linerel-2.cmodel.gz
http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/en-mixed-3.ngraphs.gz
http://iupr1.cs.uni-kl.de/~tmb/ocropus-models/en-uw3unlv-perchar.cmodel.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS=""
IUSE="examples"

RDEPEND="dev-vcs/mercurial
net-misc/curl"
DEPEND="${RDEPEND}
sci-libs/scipy
dev-python/matplotlib:=[gtk(+)]
dev-python/pytables
media-gfx/imagemagick
media-libs/opencv
dev-python/beautifulsoup
dev-python/pythonmagick"


S="${WORKDIR}/ocropus"
DOCS="${WORKDIR}/ocropus/README"

pkg_setup() {
	CHECKREQS_MEMORY="4096M"
}

#src_prepare
python_prepare_all() {
	cd ocropy
	cp ${DISTDIR}/*.gz models # skip downloading files, just copy it from sources
	if use examples; then
        DOCS="${DOCS} ${WORKDIR}/ocropus/historic-newspaper ${WORKDIR}/ocropus/uw3-500"
	fi
        distutils-r1_python_prepare_all
}

python_compile() {
	cd ocropy
	distutils-r1_python_compile

}
python_test() {
	true
	# run-test needs GDK_IS_DISPLAY to be set, do nothing
	#sed -i -e's;rm -rf temp;#rm -rf temp;' run-test	# portage/sandbox
	#sed -E -i -e's;ocropus-sauvola(.*);#ocropus-sauvola\1;' run-test # needs GDK_IS_DISPLAY to be set
	#sed -E -i -e's;ocropus-hocr(.*);#ocropus-hocr\1;' run-test # needs GDK_IS_DISPLAY to be set
	#python2.7 ${S}/ocropy/run-test

}

python_install() {
	cd ocropy
	use examples && local EXAMPLES="${WORKDIR}/examples/*"
	distutils-r1_python_install
}
