# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7
inherit cmake-utils

DESCRIPTION="Viewer for IP cameras ONVIF"
HOMEPAGE="https://gitlab.com/caspermeijn/onvifviewer/"
SRC_URI="https://gitlab.com/caspermeijn/onvifviewer/-/archive/v${PV}/${PN}-v${PV}.tar.gz"
RESTRICT="primaryuri"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="kde-frameworks/extra-cmake-modules
	kde-frameworks/kirigami
	net-libs/kdsoap"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-v${PV}"
