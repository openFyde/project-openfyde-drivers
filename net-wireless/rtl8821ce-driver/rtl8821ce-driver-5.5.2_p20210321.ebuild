# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gcc-linux-mod

COMMIT="897e7c4c15dd5a0a569745dc223d969a26ff5bfc"

DESCRIPTION="ReatlTek 8821ce wifi driver"
HOMEPAGE="https://github.com/tomaspinho/rtl8821ce/"
SRC_URI="https://github.com/tomaspinho/rtl8821ce/archive/${COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64 ~x86"

MODULE_NAMES="8821ce(net/wireless)"
MODULE_CONFIGS="CONFIG_RTL8821CE"
S="${WORKDIR}/rtl8821ce-${COMMIT}"

PATCHES=(
  "${FILESDIR}"/use-correct-kernel.patch
  "${FILESDIR}"/fix-compile-error.patch
  )

src_install() {
  gcc-linux-mod_src_install
	# Make it load
	insinto /etc/modules-load.d/
	doins -r "${FILESDIR}/rtl8821ce.conf"
}
