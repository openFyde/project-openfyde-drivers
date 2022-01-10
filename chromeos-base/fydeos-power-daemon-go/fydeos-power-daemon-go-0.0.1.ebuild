# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI="6"


EGIT_REPO_URI="${FYDEOS_GIT_HOST_BASE_URL}/fydeos-power-daemon-go.git"
EGIT_BRANCH="master"

inherit git-r3 golang-build
DESCRIPTION="fydeos power daemon in golang"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="amd64 arm"
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
  exeinto /etc/powerd
  doexe init/post_resume.sh
  doexe init/pre_suspend.sh
  keepdir /etc/powerd/board
  exeinto /usr/sbin
  doexe power_daemon
}
