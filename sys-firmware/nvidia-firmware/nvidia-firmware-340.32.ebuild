# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python3_{6..11} )
inherit python-any-r1 unpacker

NV_URI="http://us.download.nvidia.com/XFree86/"
X86_NV_PACKAGE="NVIDIA-Linux-x86-${PV}"

EXTRACT_FIRMWARE_REV="a0b9f9be0efad90cc84b8b2eaf587c3d7d350ea9"

DESCRIPTION="Kernel and mesa firmware for nouveau (video accel and pgraph)"
HOMEPAGE="https://nouveau.freedesktop.org/wiki/VideoAcceleration/"
SRC_URI="${NV_URI}Linux-x86/${PV}/${X86_NV_PACKAGE}.run
    https://raw.githubusercontent.com/envytools/firmware/${EXTRACT_FIRMWARE_REV}/extract_firmware.py -> nvidia_extract_firmware-${PV}.py"

LICENSE="MIT NVIDIA-r2"
SLOT="0"
#KEYWORDS="~x86 ~amd64"
KEYWORDS="*"

DEPEND="${PYTHON_DEPS}"
RDEPEND=""

RESTRICT="bindist mirror"

S="${WORKDIR}"

src_unpack() {
	mkdir "${S}/${X86_NV_PACKAGE}"
	cd "${S}/${X86_NV_PACKAGE}"
	unpack_makeself "${X86_NV_PACKAGE}.run"
}

src_compile() {
	python3.8 "${DISTDIR}"/nvidia_extract_firmware-${PV}.py || die "Extracting firmwares failed..."
}

src_install() {
	insinto /lib/firmware/nouveau
	doins nv* vuc-*
}
