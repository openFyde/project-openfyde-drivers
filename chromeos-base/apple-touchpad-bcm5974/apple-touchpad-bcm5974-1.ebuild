# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

EAPI=4

inherit udev

DESCRIPTION="apple touchpad with bcm5974 chip"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""
S="${WORKDIR}"

RDEPEND="
"
DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_install() {
   udev_dorules ${FILESDIR}/*.rules
   insinto /etc/gesture
   doins ${FILESDIR}/40-touchpad-cmt-apple-touchpad.conf
}
