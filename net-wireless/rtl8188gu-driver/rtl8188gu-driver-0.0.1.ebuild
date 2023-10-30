# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

COMMIT="c2b79fc1c085d9fc4a70ac0f5bc730ec929c562b"

DESCRIPTION="ReatlTek 8188gu wifi driver"
HOMEPAGE="https://github.com/McMCCRU/rtl8188gu"
SRC_URI="https://github.com/McMCCRU/rtl8188gu/archive/${COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE_KERNEL_VERS=(
  kernel-5_4
  kernel-5_10
  kernel-5_15
)
IUSE="+kernel_linux ${IUSE_KERNEL_VERS[*]}"
RESTRICT="bindist"
RESTRICT+=" mirror"

COMMON="kernel_linux? ( >=sys-libs/glibc-2.6.1 )"
DEPEND="
	${COMMON}
	dev-util/dwarves
	kernel_linux? (	virtual/linux-sources virtual/pkgconfig	)
	"
RDEPEND="virtual/linux-sources"

REQUIRED_USE="
  kernel_linux
  ?? ( ${IUSE_KERNEL_VERS[*]} )"


S="${WORKDIR}/rtl8188gu-${COMMIT}"

patch_kernel_make() {
  local patch_file=${FILESDIR}/032-use-gcc-as-complier.patch
  local reverse=$1
  pushd $KERNEL_DIR 2>&1 >/dev/null
  patch $reverse  -p1 -i $patch_file
  popd 2>&1 >/dev/null
}

apply_kernel_make_patch() {
  patch_kernel_make "-N"
}

reverse_kernel_make_patch() {
  patch_kernel_make "-R -N"
}

pkg_setup() {
	export DISTCC_DISABLE=1
	export CCACHE_DISABLE=1
  if use kernel-5_4; then
    export KERNEL_DIR="/mnt/host/source/src/third_party/kernel/v5.4"
  fi
  if use kernel-5_10; then
    export KERNEL_DIR="/mnt/host/source/src/third_party/kernel/v5.10"
  fi
  if use kernel-5_15; then
    export KERNEL_DIR="/mnt/host/source/src/third_party/kernel/v5.15"
  fi
  export KBUILD_OUTPUT=${ROOT}/usr/src/linux
  export KV_OUT_DIR=${ROOT}/usr/src/linux
  tc-export_build_env BUILD_{CC,CXX}
  einfo $KV_OUT_DIR
	linux-mod_pkg_setup
	export KVER="${KV_FULL}"
  export KSRC="$KERNEL_DIR"
  export TopDIR="$S"
#  export CONFIG_RTL8821CE=m
#  export KERNELRELEASE=1
	MODULE_NAMES="8188gu(net/wireless)"

  BUILD_PARAMS="-C ${KERNEL_DIR} -I${KBUILD_OUTPUT} O=${KBUILD_OUTPUT} M=${S} CC=${CBUILD}-gcc"
	BUILD_TARGETS="modules"
  einfo KERNELRELEASE:$KERNELRELEASE
  export CONFIG_RTL8710BU=m
}

src_prepare() {
	if kernel_is lt 4 14 0 ; then
		eerror "You must build this against 4.14.0 or higher kernels."
	fi
	default
  apply_kernel_make_patch
}

src_compile() {
	cros_allow_gnu_build_tools
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
  reverse_kernel_make_patch
}

pkg_preinst() {
	linux-mod_pkg_preinst
}

pkg_postinst() {
	linux-mod_pkg_postinst
}

pkg_postrm() {
	linux-mod_pkg_postrm
}
