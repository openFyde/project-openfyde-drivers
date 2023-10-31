# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gcc-linux-mod

COMMIT="0e435c95029ac445eadc656e6a41d2d4d20ce054"

DESCRIPTION="ReatlTek 8192eu wifi driver"
HOMEPAGE="https://github.com/clnhub/rtl8192eu-linux"
SRC_URI="https://github.com/clnhub/rtl8192eu-linux/archive/${COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

MODULE_NAMES="8192eu(net/wireless)"
MODULE_CONFIGS="CONFIG_RTL8192EU"
S="${WORKDIR}/rtl8192eu-linux-${COMMIT}"
