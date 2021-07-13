# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="7"
inherit user

DESCRIPTION="binary files for display link driver"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND="
  media-libs/evdi
  dev-libs/libusb
"

DEPEND="${RDEPEND}"

S=$FILESDIR

src_install() {
  local source_dir
  if use amd64; then
    source_dir=${FILESDIR}/amd64
  elif use arm; then
    source_dir=${FILESDIR}/arm 
  fi
  insinto /etc/init
  doins $source_dir/displaylink-driver.conf
  insinto /lib/udev/rules.d
  doins $source_dir/90-smiusbdisplay.rules
  insinto /opt
  dodir $source_dir/displaylink
  dodir $source_dir/siliconmotion
}


pkg_postinst() {
  enewuser dlm
  enewgroup dlm
}
