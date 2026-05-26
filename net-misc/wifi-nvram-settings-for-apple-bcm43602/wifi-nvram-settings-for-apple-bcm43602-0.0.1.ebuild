# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"

DESCRIPTION="empty project"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S=${WORKDIR}

DEFAULT_MAC="18:65:90:d5:cb:e3"

src_compile() {
  local mac_address=${DEFAULT_MAC}
  if [ -n "${WIFI_MAC}" ]; then
    mac_address=${WIFI_MAC}
  fi
  cat ${FILESDIR}/brcmfmac43602-pcie.txt.tpl | sed "s/xx:xx:xx:xx:xx:xx/${mac_address}/g" > brcmfmac43602-pcie.txt
}

src_install() {
  insinto /lib/firmware/brcm
  doins brcmfmac43602-pcie.txt
}
