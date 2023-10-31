# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gcc-linux-mod

COMMIT="c2b79fc1c085d9fc4a70ac0f5bc730ec929c562b"

DESCRIPTION="ReatlTek 8188gu wifi driver"
HOMEPAGE="https://github.com/McMCCRU/rtl8188gu"
SRC_URI="https://github.com/McMCCRU/rtl8188gu/archive/${COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

MODULE_NAMES="8188gu(net/wireless)"
MODULE_CONFIGS="CONFIG_RTL8710BU"
S="${WORKDIR}/rtl8188gu-${COMMIT}"
