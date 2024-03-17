# Copyright 2019-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit systemd

SRC_URI="
    x86? ( https://github.com/cloudflare/cloudflared/releases/download/${PV}/cloudflared-linux-386 -> ${P}-x86 )
    amd64? ( https://github.com/cloudflare/cloudflared/releases/download/${PV}/cloudflared-linux-amd64 -> ${P}-amd64 )
    arm? ( https://github.com/cloudflare/cloudflared/releases/download/${PV}/cloudflared-linux-arm -> ${P}-arm )
    arm64? ( https://github.com/cloudflare/cloudflared/releases/download/${PV}/cloudflared-linux-arm64 -> ${P}-arm64 )
"

KEYWORDS="~x86 ~amd64 ~x86 ~arm64 ~arm"

DESCRIPTION="Argo Tunnel client, written in GoLang"
LICENSE="Apache-2.0"
SLOT="0/${PVR}"
RESTRICT="mirror"

RDEPEND="
    !net-vpn/cloudflared
"

src_unpack() {
    mkdir -p "${S}"
    if use x86; then
		cp "${DISTDIR}/${P}-x86" ${S}/cloudflared
	elif use amd64; then
		cp "${DISTDIR}/${P}-amd64" ${S}/cloudflared
	elif use arm; then
		cp "${DISTDIR}/${P}-arm" ${S}/cloudflared
    elif use arm64; then
        cp "${DISTDIR}/${P}-arm64" ${S}/cloudflared
	else
		die "Prebuild cloudflared only supports x86, amd64, arm and arm64"
	fi
}

src_install() {
    dobin cloudflared
    insinto /etc/cloudflared
    doins "${FILESDIR}"/config.yml
    newinitd "${FILESDIR}"/cloudflared.initd cloudflared
    newconfd "${FILESDIR}"/cloudflared.confd cloudflared
    systemd_dounit "${FILESDIR}"/cloudflared.service
}
