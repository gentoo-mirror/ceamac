# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

COMMIT_SHA1=0521717c37f26fc22158e0c986f7c8b41b3fb0ee

DESCRIPTION="A fast replacement for tigetvnc"
HOMEPAGE=https://caspermeijn.gitlab.io/kdsoap-ws-discovery-client
SRC_URI=https://gitlab.com/caspermeijn/kdsoap-ws-discovery-client/-/archive/master/${PN}-${COMMIT_SHA1}.tar.gz
RESTRICT="primaryuri"

LICENSE=GPL-3
SLOT="5"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-frameworks/extra-cmake-modules:5
	dev-qt/qtcore:5
	dev-qt/qtnetwork:5
	>=net-libs/kdsoap-1.8.50"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-master-${COMMIT_SHA1}"

src_install() {
	cmake-utils_src_install
	dobin "${WORKDIR}/${P}_build/bin/onvif-discover"
}
