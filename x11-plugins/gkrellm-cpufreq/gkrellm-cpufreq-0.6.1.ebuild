# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit eutils gkrellm-plugin

MY_P=${P/gkrellm/gkrellm2}

DESCRIPTION="A Gkrellm2 plugin for displaying and manipulating CPU frequency"
HOMEPAGE="http://iacs.epfl.ch/~winkelma/gkrellm2-cpufreq/"
SRC_URI="http://iacs.epfl.ch/~winkelma/gkrellm2-cpufreq//${MY_P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

S=${WORKDIR}/${MY_P}

RDEPEND="sys-power/cpupower
		app-admin/sudo"

PLUGIN_SO=cpufreq.so

src_prepare() {
	epatch "${FILESDIR}"/${P}-use-cpupower.patch
}

src_install() {
	gkrellm-plugin_src_install
	exeinto /usr/sbin
	doexe cpufreqnextgovernor
}

pkg_postinst() {
	echo
	einfo "Add these lines to /etc/sudoers to allow users to change cpu governor and speed:"
	einfo "ALL ALL = (root) NOPASSWD: /usr/bin/cpupower -c [0-9]* frequency-set -g userspace"
	einfo "ALL ALL = (root) NOPASSWD: /usr/bin/cpupower -c [0-9]* frequency-set -f [0-9]*"
	einfo "ALL ALL = (root) NOPASSWD: /usr/sbin/cpufreqnextgovernor"
	echo
}
