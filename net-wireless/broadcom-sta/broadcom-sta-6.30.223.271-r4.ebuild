# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit eutils linux-info clang-linux-mod

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

pkg_setup() {
	CONFIG_CHECK="~!B43 ~!BCMA ~!SSB ~!CC_IS_CLANG"
	CONFIG_CHECK2="LIB80211 ~!MAC80211 ~LIB80211_CRYPT_TKIP"
	ERROR_B43="B43: If you insist on building this, you must blacklist it!"
	ERROR_BCMA="BCMA: If you insist on building this, you must blacklist it!"
	ERROR_SSB="SSB: If you insist on building this, you must blacklist it!"
	ERROR_LIB80211="LIB80211: Please enable it. If you can't find it: enabling the driver for \"Intel PRO/Wireless 2100\" or \"Intel PRO/Wireless 2200BG\" (IPW2100 or IPW2200) should suffice."
	ERROR_MAC80211="MAC80211: If you insist on building this, you must blacklist it!"
	ERROR_PREEMPT_RCU="PREEMPT_RCU: Please do not set the Preemption Model to \"Preemptible Kernel\"; choose something else."
	ERROR_LIB80211_CRYPT_TKIP="LIB80211_CRYPT_TKIP: You will need this for WPA."
	if kernel_is ge 3 8 8; then
		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} CFG80211 ~!PREEMPT_RCU ~!PREEMPT"
	elif kernel_is ge 2 6 32; then
		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} CFG80211"
	elif kernel_is ge 2 6 31; then
		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} WIRELESS_EXT ~!MAC80211"
	elif kernel_is ge 2 6 29; then
		CONFIG_CHECK="${CONFIG_CHECK} ${CONFIG_CHECK2} WIRELESS_EXT COMPAT_NET_DEV_OPS"
	else
		CONFIG_CHECK="${CONFIG_CHECK} IEEE80211 IEEE80211_CRYPT_TKIP"
	fi
	clang-linux-mod_pkg_setup
}

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
  "${FILESDIR}/018-broadcom-wl-fix-linux-6.13.patch"
  "${FILESDIR}/019-broadcom-wl-fix-linux-6.14.patch"
  "${FILESDIR}/020-broadcom-wl-fix-linux-6.15.patch"
)
