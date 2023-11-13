# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gcc-linux-mod

COMMIT="78bbe0258d227174eb6e4594b42c32c357cd3cf6"

DESCRIPTION="ReatlTek 8192fu wifi driver"
HOMEPAGE="https://github.com/BrightX/rtl8192fu.git"
SRC_URI="https://github.com/BrightX/rtl8192fu/archive/${COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 ~x86"

MODULE_NAMES="8192fu(net/wireless)"
MODULE_CONFIGS="CONFIG_RTL8192FU"
S="${WORKDIR}/rtl8192fu-${COMMIT}"

src_install() {
  gcc-linux-mod_src_install
  insinto /lib/udev/rules.d
  doins ${FILESDIR}/99-rtl8192fu-dongle.rules
  exeinto /lib/udev
  doexe ${FILESDIR}/eject.sh
}
