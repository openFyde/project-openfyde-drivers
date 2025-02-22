# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="tool to manipulate Intel X86 and X86-64 processor microcode update collections"
HOMEPAGE="https://gitlab.com/iucode-tool/"
SRC_URI="https://gitlab.com/iucode-tool/releases/raw/master/${PN/_/-}_${PV}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* amd64 x86"

RDEPEND="elibc_musl? ( sys-libs/argp-standalone )"
DEPEND="${RDEPEND}"
RESTRICT="mirror"

S="${WORKDIR}/${PN/_/-}-${PV}"

PATCHES=(
	"${FILESDIR}"/${PN}-2.3.1-limits-include.patch
)
