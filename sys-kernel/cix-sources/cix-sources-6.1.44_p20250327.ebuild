EAPI=8

ETYPE="sources"
K_WANT_GENPATCHES="base extras"
K_GENPATCHES_VER="45"

inherit kernel-2
detect_version
detect_arch

DESCRIPTION="CIX BSP kernel sources based on Linux ${KV_MAJOR}.${KV_MINOR}.${KV_PATCH} with Gentoo patches"
HOMEPAGE="https://gitlab.com/cix-linux/cix_opensource/linux"

SRC_URI="
    https://gitlab.com/hacc1225/cix-linux/-/archive/${PV##*_p}/cix-linux-${PV##*_p}.tar.gz -> linux-${KV_MAJOR}.${KV_MINOR}.tar.gz
    ${GENPATCHES_URI}
"

S="${WORKDIR}/linux-${PV%%_*}-${PV##*_p}-cix"

KEYWORDS="~arm64"
IUSE="experimental"

src_unpack() {
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
