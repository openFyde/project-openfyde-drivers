# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

EAPI=7
inherit arc-camera
DESCRIPTION="support most of usb-cameras"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="*"
IUSE="fydeos_arc android-container-pi"

RDEPEND=""

DEPEND="${RDEPEND}"
S=${WORKDIR}

src_install() {
    insinto /etc/camera
    if ! use android-container-pi;then
        doins ${FILESDIR}/camera_characteristics.conf
        use fydeos_arc && arc-camera_gen_and_install_rules
    fi
}
