# Copyright 2024-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit clang-linux-mod

DESCRIPTION="APFS module for linux, with experimental write support"
HOMEPAGE="https://github.com/linux-apfs/linux-apfs-rw"
SRC_URI="https://github.com/linux-apfs/linux-apfs-rw/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64"

CONFIG_CHECK="LIBCRC32C"
MODULE_NAMES="apfs(fs/apfs)"

PATCHES=( "${FILESDIR}/001-fix-compiling-error-for-6.12.patch" )

pkg_setup() {
	clang-linux-mod_pkg_setup
}

src_prepare() {
	default
	sed -e "s/GIT_COMMIT=.*/GIT_COMMIT=${PV}/" -i genver.sh || die
	# clang-linux-mod builds via kbuild directly and never runs the Makefile's
	# "default" target, so generate version.h here or super.c fails to compile.
	./genver.sh || die
}

src_compile() {
	local modlist=( apfs=extra )
	local modargs=( KERNEL_DIR=${KV_OUT_DIR} KERNELRELEASE=${KV_FULL} )

  clang-linux-mod_src_compile
}
