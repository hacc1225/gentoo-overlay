# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

ETYPE="sources"
KERNEL_URI="https://gitlab.com/hacc1225/cix-linux.git"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="45"
K_FROM_GIT="yes"

EGIT_REPO_URI="${KERNEL_URI}"
EGIT_COMMIT="${PV##*_p}"
EGIT_CLONE_TYPE="shallow"
EGIT_CHECKOUT_DIR="${WORKDIR}/linux-${PV%%_*}-cix"

inherit git-r3 kernel-2
handle_genpatches
detect_version
detect_arch

DESCRIPTION="CIX BSP kernel sources based on Linux ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH} with Gentoo patches"
HOMEPAGE="https://gitlab.com/cix-linux/cix_opensource/linux"
SRC_URI="${GENPATCHES_URI}"
KEYWORDS="~arm64"
IUSE="experimental"

S="${EGIT_CHECKOUT_DIR}"

src_unpack() {
    git-r3_src_unpack
    kernel-2_src_unpack
}

src_prepare() {
    kernel-2_src_prepare
}

pkg_postinst() {
    kernel-2_pkg_postinst
    einfo "For more information on this kernel, visit:"
    einfo "${HOMEPAGE}"
}
