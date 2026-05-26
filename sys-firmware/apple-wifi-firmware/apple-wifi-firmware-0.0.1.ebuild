# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="Apple broadcom WiFi firmwares"
HOMEPAGE="http://fydeos.com"

inherit fydeos-ftp

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="x86 amd64"
IUSE="compress-xz compress-zstd"

BDEPEND="
  compress-xz? ( app-arch/xz-utils )
  compress-zstd? ( app-arch/zstd )
"
RDEPEND=""
DEPEND="${RDEPEND}"

src_compile() {
  if use compress-xz || use compress-zstd; then
    pushd "brcm" &>/dev/null || die
    einfo "Compressing firmware ..."
    local ext
    local compressor

    if use compress-xz; then
      ext=xz
      compressor="xz -T1 -C crc32"
    elif use compress-zstd; then
      ext=zst
      compressor="zstd -15 -T1 -C -q --rm"
    fi
    find . -type f -print0 | \
      xargs -0 -P 8 -I'{}' ${compressor} '{}'
    assert
    popd &>/dev/null || die
  fi
}

src_install() {
  insinto /lib/firmware
  doins -r brcm
}
