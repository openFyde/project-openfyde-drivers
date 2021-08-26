# Copyright 2018-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit linux-mod

COMMIT="897e7c4c15dd5a0a569745dc223d969a26ff5bfc"

DESCRIPTION="ReatlTek 8821ce wifi driver"
HOMEPAGE="https://github.com/tomaspinho/rtl8821ce/"
SRC_URI="https://github.com/tomaspinho/rtl8821ce/archive/${COMMIT}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~x86"
IUSE_KERNEL_VERS=(
  kernel-3_8
  kernel-3_10
  kernel-3_14
  kernel-3_18
  kernel-4_4
  kernel-4_12
  kernel-4_14
  kernel-4_19
  kernel-5_4
  kernel-5_10
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


S="${WORKDIR}/rtl8821ce-${COMMIT}"

PATCHES=( 
  "${FILESDIR}"/use-correct-kernel.patch 
  "${FILESDIR}"/fix-compile-error.patch
  )

patch_kernel_make() {
  local patch_file=${FILESDIR}/kernel-5.4-make-gcc-compile.patch
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
  if use kernel-4_14; then
    export KERNEL_DIR="/mnt/host/source/src/third_party/kernel/v4.14"
  fi
  if use kernel-4_19; then
    export KERNEL_DIR="/mnt/host/source/src/third_party/kernel/v4.19"
  fi
  if use kernel-5_4; then
    export KERNEL_DIR="/mnt/host/source/src/third_party/kernel/v5.4"
  fi
  if use kernel-5_10; then
    export KERNEL_DIR="/mnt/host/source/src/third_party/kernel/v5.10"
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
	MODULE_NAMES="8821ce(net/wireless)"

  BUILD_PARAMS="-C ${KERNEL_DIR} -I${KBUILD_OUTPUT} O=${KBUILD_OUTPUT} M=${S} CC=${CBUILD}-gcc"
	BUILD_TARGETS="modules"
  einfo KERNELRELEASE:$KERNELRELEASE
  export CONFIG_RTL8821CE=m
}

src_prepare() {
	if kernel_is lt 4 14 0 ; then
		eerror "You must build this against 4.14.0 or higher kernels."
	fi
	default
  apply_kernel_make_patch
}

src_compile() {
	linux-mod_src_compile
}

src_install() {
	linux-mod_src_install
  reverse_kernel_make_patch
	# Make it load
	insinto /etc/modules-load.d/
	doins -r "${FILESDIR}/rtl8821ce.conf"
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
