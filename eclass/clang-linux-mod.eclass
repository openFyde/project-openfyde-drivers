# Copyright 1999-202r32 FydeOS Authors
# Distributed under the terms of the GNU General Public License v2

# @ECLASS: gcc-linux-mod.eclass
# @MAINTAINER:
# Yang Tsao <yang@fydeos.io>
# @SUPPORTED_EAPIS: 6 7 8
# @BLURB: We always build kernel with clang, but a lot of individual kernel modules doesn't support clang.


if [[ -z ${_GCC_LINUX_MOD_ECLASS} ]]; then
_GCC_LINUX_MOD_ECLASS=1
inherit linux-mod cros-toolchain-funcs

IUSE_KERNEL_VERS=(
  kernel-5_4
  kernel-5_10
  kernel-5_15
  kernel-6_6
)

IUSE="${IUSE_KERNEL_VERS[*]} +clang asan"

RESTRICT="bindist"
RESTRICT+=" mirror"

COMMON=">=sys-libs/glibc-2.6.1"

DEPEND="
  ${COMMON}
  dev-util/dwarves
  virtual/linux-sources
  virtual/pkgconfig
"

RDEPEND="virtual/linux-sources"

REQUIRED_USE="?? ( ${IUSE_KERNEL_VERS[*]} )"

# @ECLASS_VARIABLE: MODULE_CONFIGS
# @USER_VARIABLE
# @DESCRIPTION:
# the kernel configs to export before setup build env
MODULE_CONFIGS=

# @ECLASS_VARIABLE: USER_KERNEL_SRC
# @USER_VARIABLE
# @DESCRIPTION:
# the kernel src to override system kernel src
USER_KERNEL_SRC=

# @ECLASS_VARIABLE: USER_KERNEL_PATCH
# @USER_VARIABLE
# @DESCRIPTION:
# the kernel patch to override default patch
USER_KERNEL_PATCH=

_SRC_PATH="/mnt/host/source/src"
_KERNEL_DIR="${_SRC_PATH}/third_party/kernel"

get_kernel_source() {
  if [ -n "$USER_KERNEL_SRC" ]; then
    echo $USER_KERNEL_SRC
  elif use kernel-5_4; then
    echo "${_KERNEL_DIR}/v5.4"
  elif use kernel-5_10; then
    echo "${_KERNEL_DIR}/v5.10"
  elif use kernel-5_15; then
    echo "${_KERNEL_DIR}/v5.15"
  elif use kernel-6_6; then
    echo "${_KERNEL_DIR}/v6.6"
  fi
}

clang-linux-mod_pkg_setup() {
  export DISTCC_DISABLE=1
  export CCACHE_DISABLE=1
  export KERNEL_DIR=`get_kernel_source`
  export KBUILD_OUTPUT=${ROOT}/usr/src/linux
  export KV_OUT_DIR=${ROOT}/usr/src/linux
  clang-setup-env
  einfo $KV_OUT_DIR
  linux-mod_pkg_setup
  export KVER="${KV_FULL}"
  export KSRC="$KERNEL_DIR"
  export TopDIR="$S"
  BUILD_PARAMS="-C ${KERNEL_DIR} -I${KBUILD_OUTPUT} O=${KBUILD_OUTPUT} M=${S} CC=${CBUILD}-clang"
  BUILD_TARGETS="modules"
  einfo KERNELRELEASE:$KERNELRELEASE
  for config in $MODULE_CONFIGS; do
    export ${config}=m
  done
}

clang-linux-mod_src_compile() {
  cros_allow_gnu_build_tools
  linux-mod_src_compile
}

EXPORT_FUNCTIONS pkg_setup src_compile
fi #_GCC_LINUX_MOD_ECLASS

