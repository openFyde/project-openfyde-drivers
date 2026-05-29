# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit clang-linux-mod

DESCRIPTION="Broadcom's IEEE 802.11a/b/g/n hybrid Linux device driver"
HOMEPAGE="https://www.broadcom.com/support/802.11"
SRC_BASE="https://docs.broadcom.com/docs-and-downloads/docs/linux_sta/hybrid-v35"
SRC_URI="x86? ( ${SRC_BASE}-nodebug-pcoem-${PV//\./_}.tar.gz )
	amd64? ( ${SRC_BASE}_64-nodebug-pcoem-${PV//\./_}.tar.gz )
	https://docs.broadcom.com/docs-and-downloads/docs/linux_sta/README_${PV}.txt -> README-${P}.txt"

LICENSE="Broadcom"
#KEYWORDS="-* ~amd64 ~x86"
KEYWORDS="-* amd64 x86"

MODULE_NAMES="wl(net/wireless)"
MODULESD_WL_ALIASES=("wlan0 wl")
S=${WORKDIR}

src_install() {
  linux-mod_src_install
	rm -f ${ED}/etc/modprobe.d/wl.conf

	dodoc "${DISTDIR}/README-${P}.txt"

	insinto /etc/modprobe.d
	doins ${FILESDIR}/modprobe/*

  insinto /lib/udev/rules.d
  doins ${FILESDIR}/rules/*

	# Install this per license requirement
	insinto /usr/share/license
	newins ${S}/lib/LICENSE.txt ${PN}-license.txt
}

PATCHES=(
  "${FILESDIR}/001-null-pointer-fix.patch"
  "${FILESDIR}/002-rdtscl.patch"
  "${FILESDIR}/003-linux47.patch"
  "${FILESDIR}/004-linux48.patch"
  "${FILESDIR}/005-debian-fix-kernel-warnings.patch"
  "${FILESDIR}/006-linux411.patch"
  "${FILESDIR}/007-linux412.patch"
  "${FILESDIR}/008-linux415.patch"
  "${FILESDIR}/009-fix_mac_profile_discrepancy.patch"
  "${FILESDIR}/010-linux56.patch"
  "${FILESDIR}/011-linux59.patch"
  "${FILESDIR}/012-linux517.patch"
  "${FILESDIR}/013-linux518.patch"
  "${FILESDIR}/014-linux414.patch"
  "${FILESDIR}/015-linux600.patch"
  "${FILESDIR}/016-linux601.patch"
  "${FILESDIR}/017-handle-new-header-name-6.12.patch"
)
#  "${FILESDIR}/018-broadcom-wl-fix-linux-6.13.patch"
#  "${FILESDIR}/019-broadcom-wl-fix-linux-6.14.patch"
#  "${FILESDIR}/020-broadcom-wl-fix-linux-6.15.patch"
