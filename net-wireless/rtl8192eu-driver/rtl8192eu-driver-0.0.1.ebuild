# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit clang-linux-mod

COMMIT="85f3b62620b5eb7931fa129730820ae6693216ac"
COMMIT="ee928d5dc065f328043711c271eb54f008e6245c"

DESCRIPTION="ReatlTek 8192eu wifi driver"
HOMEPAGE="https://github.com/clnhub/rtl8192eu-linux"
SRC_URI="https://github.com/clnhub/rtl8192eu-linux/archive/${COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm64"

MODULE_NAMES="8192eu(net/wireless)"
MODULE_CONFIGS="CONFIG_RTL8192EU"
S="${WORKDIR}/rtl8192eu-linux-${COMMIT}"

#PATCHES=( ${FILESDIR}/001-adapt-to-kernel-6_6.patch )
