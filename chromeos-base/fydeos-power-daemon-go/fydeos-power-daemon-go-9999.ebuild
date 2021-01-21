# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="6"

CROS_WORKON_PROJECT="chromiumos/third_party/fydeos-power-daemon"
#CROS_WORKON_LOCALNAME="fydeos-power-daemon"

inherit cros-workon golang-build
DESCRIPTION="fydeos power daemon in golang"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="~*"
IUSE=""

RDEPEND="
  "

DEPEND="${RDEPEND}
  dev-lang/go
  dev-go/dbus
"

EGO_PN="fydeos.com/power_daemon"


src_compile() {
   GOARCH=$ARCH golang-build_src_compile
}
get_golibdir() {
  echo "/usr/lib/gopath"  
}

src_install() {
  insinto /etc/init
  doins init/fydeos-power-daemon.conf
  insinto /etc/powerd
  doins init/post_resume.sh
  doins init/pre_suspend.sh
  keepdir /etc/powerd/board
  exeinto /usr/sbin
  doexe power_daemon
}
