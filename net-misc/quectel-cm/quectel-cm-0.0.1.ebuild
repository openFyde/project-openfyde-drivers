# Copyright (c) 2018 The Fyde OS Authors. All rights reserved.
# Distributed under the terms of the BSD

EAPI=7

EGIT_REPO_URI="git@gitlab.fydeos.xyz:misc/quectel-cm.git"
EGIT_COMMIT="53e4a3a135dda98398c10ca44f84be8aca98d28e"

inherit autotools git-r3 eutils flag-o-matic

DESCRIPTION="Quectel modem data service for board fydetab_duo"
HOMEPAGE="http://fydeos.com"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="*"
IUSE=""

RDEPEND=""

DEPEND="${RDEPEND}"

src_prepare() {
  if use arm; then
    append-cflags -D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64
  fi
}

src_install() {
  dobin quectel-CM
  dobin quectel-mbim-proxy
  dobin quectel-qmi-proxy
#  insinto /etc/init
#  doins ${FILESDIR}/init-quectel-service.conf
}
