# Copyright (c) 2023 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.


EAPI=5

DESCRIPTION="rtw8852 firmware files"

inherit user

LICENSE="GPL-2"
SLOT="0"

KEYWORDS="-* amd64 x86"

RDEPEND="sys-kernel/linux-firmware"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
    insinto /lib/firmware/rw89/
    doins -r ${FILESDIR}/*
}
