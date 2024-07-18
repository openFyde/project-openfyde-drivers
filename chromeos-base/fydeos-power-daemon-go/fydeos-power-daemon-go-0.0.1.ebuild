# Copyright (c) 2022 Fyde Innovations Limited and the openFyde Authors.
# Distributed under the license specified in the root directory of this project.

EAPI=7


EGIT_REPO_URI="${OPENFYDE_GIT_HOST_URL}/fydeos-power-daemon-go.git"
EGIT_BRANCH="r126-dev"

inherit git-r3 golang-build
DESCRIPTION="fydeos power daemon in golang"
HOMEPAGE="http://fydeos.com"

LICENSE="BSD-Google"
SLOT="0"
KEYWORDS="amd64 arm arm64"
IUSE=""

RDEPEND="
  "

DEPEND="${RDEPEND}
  dev-lang/go
  dev-go/dbus
"

EGO_PN="fydeos.com/power_daemon"


src_compile() {
   export GO111MODULE=auto
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
