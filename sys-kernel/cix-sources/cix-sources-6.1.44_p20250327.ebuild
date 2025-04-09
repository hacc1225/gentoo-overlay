# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

ETYPE="sources"
K_FROM_GIT="yes"
KERNEL_URI="https://gitlab.com/hacc1225/cix-linux.git"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="45"
K_NOUSENAME="yes"
K_NOSETEXTRAVERSION="yes"
K_NOUSEPR="yes"
K_SECURITY_UNSUPPORTED="1"

inherit kernel-2
detect_version

K_GIT_TAG="${PV##*_p}"

DESCRIPTION="CIX BSP kernel sources based on Linux ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH} with Gentoo patches"
HOMEPAGE="https://gitlab.com/hacc1225/cix-linux"
SRC_URI=""

KEYWORDS="~arm64"
IUSE="experimental"

S="${WORKDIR}/${P}"

pkg_postinst() {
    kernel-2_pkg_postinst
    einfo "For more information on this kernel, visit:"
    einfo "${HOMEPAGE}"
}
