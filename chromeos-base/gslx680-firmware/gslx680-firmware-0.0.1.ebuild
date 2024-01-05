# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

EAPI=7

DESCRIPTION="firmware for silead/mssl1680"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"
S="${WORKDIR}"

src_install() {
    insinto /lib/firmware/silead
    doins ${FILESDIR}/mssl1680.fw
}
