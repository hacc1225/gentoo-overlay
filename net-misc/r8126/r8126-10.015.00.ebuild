# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit linux-mod-r1

DESCRIPTION="r8126 vendor driver for Realtek RTL8125 PCI-E NICs"
HOMEPAGE="https://www.realtek.com/Download/List?cate_id=584"
# Mirrored to avoid captcha
SRC_URI="https://github.com/openwrt/rtl8126/releases/download/${PV}/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86 ~arm64"

IUSE="+multi-tx-q ptp +rss use-firmware"

PATCHES=(
	"${FILESDIR}/${P}-ptp-linux-6.11.patch"
)

CONFIG_CHECK="~!R8169"
WARNING_R8169="CONFIG_R8169 is enabled. ${PN} will not be loaded unless kernel driver Realtek 8169 PCI Gigabit Ethernet (CONFIG_R8169) is DISABLED."

src_prepare() {
	default

	local module_makefile="${S}/src/Makefile"

	if [[ ! -f "${module_makefile}" ]]; then
		die "Makefile not found at ${module_makefile}"
	fi

	sed -i 's/EXTRA_CFLAGS *+=/ccflags-y +=/g' "${module_makefile}" || die "sed replacement failed for EXTRA_CFLAGS in ${module_makefile}"

	 einfo "Replaced EXTRA_CFLAGS with ccflags-y"
}

src_compile() {
	local modlist=( ${PN}=kernel/drivers/net/ethernet/realtek:src )
	local modargs=(
		# Build parameters
		KERNELDIR="${KV_OUT_DIR}"
		# Configuration settings
		ENABLE_PTP_SUPPORT=$(usex ptp y n)
		ENABLE_RSS_SUPPORT=$(usex rss y n)
		ENABLE_MULTIPLE_TX_QUEUE=$(usex multi-tx-q y n)
		ENABLE_USE_FIRMWARE_FILE=$(usex use-firmware y n)
		ENABLE_PAGE_REUSE=y
		ENABLE_RX_PACKET_FRAGMENT=y
		ENABLE_DOUBLE_VLAN=y
	)

	linux-mod-r1_src_compile
}
