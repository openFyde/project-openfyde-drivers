# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI=7

DESCRIPTION="empty project"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S=${FILESDIR}

src_install() {
  insinto /lib/firmware
  doins -r *
  # sys-kernel/linux-firmware ships these two as .bin.xz and the kernels
  # decompress via FW_LOADER_COMPRESS_XZ; don't install plain duplicates.
  rm "${D}/lib/firmware/mediatek/WIFI_MT7961_patch_mcu_1_2_hdr.bin" \
     "${D}/lib/firmware/mediatek/WIFI_RAM_CODE_MT7961_1.bin" || die
}
