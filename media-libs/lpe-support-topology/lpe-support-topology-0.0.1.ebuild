# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

# Copyright 2018 The Chromium OS Authors. All rights reserved.
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="Topology binary files used to support/configure LPE Audio"

LICENSE="LICENCE.IntcSST2"
SLOT="0"
KEYWORDS="*"
IUSE="-original_device_topology_bin"

DEPEND="
	media-sound/alsa-utils media-libs/alsa-lib
	media-libs/apl-hotword-support
"

S=${WORKDIR}

src_compile() {
	local use_org_bin=$(usex original_device_topology_bin true false)

	if [[ ${use_org_bin} = "false" ]]; then
		einfo "Compiling audio topology binary"
		alsatplg -c "${FILESDIR}"/bxt_i2s.conf -o dfw_sst.bin || die
	fi
}

src_install() {
	local src_dir=$(usex original_device_topology_bin "${FILESDIR}" "${WORKDIR}")
	insinto /lib/firmware
	doins "${src_dir}"/dfw_sst.bin
}
