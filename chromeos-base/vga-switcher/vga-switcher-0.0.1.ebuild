# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

EAPI="5"

DESCRIPTION="empty project"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

S=${WORKDIR}

src_install() {
  insinto /lib/udev/rules.d
  doins ${FILESDIR}/99-vga-switch.rules
  exeinto /lib/udev
  doexe ${FILESDIR}/vga-switch.sh
}
