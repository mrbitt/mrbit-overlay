# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit git-r3

DESCRIPTION="Script that updates DNS settings are pushed by the OpenVPN server"
HOMEPAGE="https://github.com/masterkorp/openvpn-update-resolv-conf"
EGIT_REPO_URI="https://github.com/masterkorp/openvpn-update-resolv-conf"

SLOT="0"
KEYWORDS="amd64"

RDEPEND="app-shells/bash:0
	net-dns/openresolv
	net-vpn/openvpn"

src_install() {
	local install="/etc/openvpn"
	fperms +x "${PN}.sh"
	insinto "${install}"
	newins ${PN}.sh ${PN}

}
